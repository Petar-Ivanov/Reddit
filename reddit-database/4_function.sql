GO

CREATE FUNCTION dbo.CalculateKarma(@user_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @karma INT = 0;
    
    SELECT @karma = @karma + (COUNT(*) * 10)
    FROM post_award pa
    JOIN post p ON pa.post_id = p.post_id
    WHERE p.user_id = @user_id;
    
    SELECT @karma = @karma + (COUNT(*) * 5)
    FROM comment_award ca
    JOIN comment c ON ca.comment_id = c.comment_id
    WHERE c.user_id = @user_id;
    
    RETURN @karma;
END;

GO

--SELECT dbo.CalculateKarma(2);

