// devops-shared/vars/prepareEnv.groovy
def call() {
    echo "Preparing environment..."

    // get the scm info from Jenkins global var
    def commitAuthor = env.GIT_COMMITTER_NAME ?: "Unknown"
    def commitMessage = env.GIT_COMMIT_MESSAGE ?: "No message provided"

    // keep in var to be available in other pipeline's stages
    env.COMMIT_AUTHOR = commitAuthor
    env.COMMIT_MESSAGE = commitMessage

    // save in file for feature debug
    writeFile file: 'commit_info.txt', text: "Commit by: ${commitAuthor}\nMessage: ${commitMessage}"

    echo "Commit information saved to commit_info.txt"
}
