GO

CREATE PROCEDURE GetSubredditMembers
    @subreddit_id INT
AS
BEGIN
    SELECT u.user_id, u.username
    FROM [user] u
    JOIN membership m ON u.user_id = m.user_id
    WHERE m.subreddit_id = @subreddit_id;
END

Go

--EXEC GetSubredditMembers @subreddit_id = 2;