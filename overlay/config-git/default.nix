{ mutate, secrets }: mutate ./gitconfig {
    git_user_name = secrets.name;
    git_user_email = secrets.email;
}
