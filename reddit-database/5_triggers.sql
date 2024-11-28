GO

CREATE TRIGGER dbo.UpdateKarmaOnPostAward
ON post_award
AFTER INSERT
AS
BEGIN
    DECLARE @user_id INT;

    SELECT @user_id = user_id FROM INSERTED;

    UPDATE [user]
    SET karma = dbo.CalculateKarma(@user_id)
    WHERE user_id = @user_id;
END;

GO

CREATE TRIGGER dbo.UpdateKarmaOnCommentAward
ON comment_award
AFTER INSERT
AS
BEGIN
    DECLARE @user_id INT;

    SELECT @user_id = user_id FROM INSERTED;

    UPDATE [user]
    SET karma = dbo.CalculateKarma(@user_id)
    WHERE user_id = @user_id;
END;



