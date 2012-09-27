#
# Amazon AWS Dev Tools
#

# Used by all CLI tools produced by Amazon
export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"

# ec2-dev-tools
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"

# ec2-ami-tools
export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"

# aws-sns-cli
export AWS_SNS_HOME="/usr/local/Library/LinkedKegs/aws-sns-cli/jars"

# Further AWS configuration that must be hidden from Git.
source "$ZSH/config/aws.zsh"
