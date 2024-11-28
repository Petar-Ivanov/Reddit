CREATE DATABASE forum_db;

USE forum_db;

CREATE TABLE country (
    country_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL,
    iso VARCHAR(4) UNIQUE NOT NULL
);

CREATE TABLE [user] (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(35) UNIQUE NOT NULL,
    password VARCHAR(15) NOT NULL,
    email VARCHAR(35) UNIQUE NOT NULL,
    birthdate DATETIME2 NOT NULL,
    picture_url VARCHAR(255) NULL, 
    phone VARCHAR(15) NOT NULL,
    is_admin BIT DEFAULT 0 NOT NULL,
    karma INT DEFAULT 0 NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE subreddit (
    subreddit_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(50) UNIQUE NOT NULL,
    description VARCHAR(200) NULL,
    rules VARCHAR(200) NULL,
    picture_url VARCHAR(255) NULL,
    banner_url VARCHAR(255) NULL,
    created_at DATETIME2 NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [user](user_id)
);

CREATE TABLE moderator (
    moderator_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    subreddit_id INT NOT NULL,
    UNIQUE (user_id, subreddit_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (subreddit_id) REFERENCES subreddit(subreddit_id)
);

CREATE TABLE follow (
    follow_id INT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME2 NOT NULL,
    follower_id INT NOT NULL,
    followed_id INT NOT NULL,
    UNIQUE (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES [user](user_id),
    FOREIGN KEY (followed_id) REFERENCES [user](user_id)
);

CREATE TABLE message (
    message_id INT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME2 NOT NULL,
    text VARCHAR(200) NOT NULL,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    FOREIGN KEY (sender_id) REFERENCES [user](user_id),
    FOREIGN KEY (receiver_id) REFERENCES [user](user_id)
);

CREATE TABLE membership (
    membership_id INT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME2 NOT NULL,
    user_id INT NOT NULL,
    subreddit_id INT NOT NULL,
    UNIQUE (user_id, subreddit_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (subreddit_id) REFERENCES subreddit(subreddit_id)
);

CREATE TABLE post (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    text VARCHAR(200) NOT NULL,
    resource_url VARCHAR(255) NULL,
    created_at DATETIME2 NOT NULL,
    edited_at DATETIME2 NULL,
    user_id INT NOT NULL,
    subreddit_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (subreddit_id) REFERENCES subreddit(subreddit_id)
);

CREATE TABLE topic (
    topic_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(200) NULL
);

CREATE TABLE comment (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    text VARCHAR(200) NOT NULL,
    created_at DATETIME2 NOT NULL,
    edited_at DATETIME2 NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    parent_id INT NULL,
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (parent_id) REFERENCES comment(comment_id)
);

CREATE TABLE post_vote (
    vote_id INT IDENTITY(1,1) PRIMARY KEY,
    vote_type BIT NOT NULL,
    created_at DATETIME2 NOT NULL,
    edited_at DATETIME2 NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    UNIQUE (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

CREATE TABLE comment_vote (
    vote_id INT IDENTITY(1,1) PRIMARY KEY,
    vote_type BIT NOT NULL,
    created_at DATETIME2 NOT NULL,
    edited_at DATETIME2 NULL,
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    UNIQUE (user_id, comment_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id)
);

CREATE TABLE award_type (
    award_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE post_award (
    award_id INT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME2 NOT NULL,
    award_type_id INT NOT NULL,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    UNIQUE (user_id, post_id, award_type_id),
    FOREIGN KEY (award_type_id) REFERENCES award_type(award_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id)
);

CREATE TABLE comment_award (
    award_id INT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME2 NOT NULL,
    award_type_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    UNIQUE (user_id, comment_id, award_type_id),
    FOREIGN KEY (award_type_id) REFERENCES award_type(award_id),
    FOREIGN KEY (user_id) REFERENCES [user](user_id),
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id)
);

CREATE TABLE subreddit_topic (
    subreddit_topic_id INT IDENTITY(1,1) PRIMARY KEY,
    subreddit_id INT NOT NULL,
    topic_id INT NOT NULL,
    UNIQUE (subreddit_id, topic_id),
    FOREIGN KEY (subreddit_id) REFERENCES subreddit(subreddit_id),
    FOREIGN KEY (topic_id) REFERENCES topic(topic_id)
);

CREATE TABLE post_topic (
    post_topic_id INT IDENTITY(1,1) PRIMARY KEY,
    post_id INT NOT NULL,
    topic_id INT NOT NULL,
    UNIQUE (post_id, topic_id),
    FOREIGN KEY (post_id) REFERENCES post(post_id),
    FOREIGN KEY (topic_id) REFERENCES topic(topic_id)
);
