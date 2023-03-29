local {
  id           = split("-", uuid())[0]
  topic_name   = coalesce(var.topic_name, format("%s-%s", "topic", local.id))
  display_name = coalesce(var.display_name, format("%s-%s", "topic", local.id))
}

#-------------------------------------------------------------------------------
# SIMPLE NOTIFICATION SERVICE (SNS) TOPIC SPECIFICATIONS
#-------------------------------------------------------------------------------
resource "aws_sns_topic" "this" {
  name         = local.topic_name
  display_name = local.display_name


  fifo_topic = var.fifo_topic
  delivery_policy = jsonencode({
    http = {
      defaultHealthyRetryPolicy = {
        minDelayTarget     = var.min_delay_target
        maxDelayTarget     = var.max_delay_target
        numRetries         = var.num_retries
        numMaxDelayRetries = var.num_max_delay_retries
        numNoDelayRetries  = var.num_no_delay_retries
        numMinDelayRetries = var.num_min_delay_retries
        backoffFunction    = var.backoff_function
      }
      disableSubscriptionOverrides = var.disable_subscription_overrides
      defaultThrottlePolicy = {
        maxReceivesPerSecond = var.max_receives_per_second
      }
    }
  })
  tags = merge({ Name = local.topic_name }, var.tags)
}

#-------------------------------------------------------------------------------
# SIMPLE NOTIFICATION SERVICE (SNS) TOPIC POLICY
#-------------------------------------------------------------------------------
data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]
    resources = [
      aws_sns_topic.this.arn
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
resource "aws_sns_topic_policy" "this" {
  arn    = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}
