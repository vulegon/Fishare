resource "aws_iam_user" "user" {
  name = "${var.env}-user"
}

resource "aws_iam_group" "developers" {
  name = "${var.env}-developers"
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  group = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  user = aws_iam_user.user.name
  groups = [aws_iam_group.developers.name]
  depends_on = [aws_iam_group_policy_attachment.group_policy]
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.user.name
}
