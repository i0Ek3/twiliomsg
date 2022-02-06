#!/bin/bash

read_info() {
    echo -e "\033[36mWhat's your phone number? [like 12132832283]\033[0m"
    read from
    echo -e "\033[36mWhose number is used to receive? [like 1213282283]\033[0m"
    read to
    echo -e "\033[36mWhat's content you want to send? [like \"hi there\"]\033[0m"
    read body
}

send_by_cli() {
    twilio api:core:messages:create \
        --body $body \
        --from +$from \
        --to +$to
}

preinstall() {
    platform=$(uname -s)

    if [ $platform == "Darwin" ]
    then
        brew tap twilio/brew && brew install twilio
        brew install jq
    elif [ $platform == 'Linux' ]
    then
        sudo apt install -y twilio jq
    else
        echo "Unsupport platform!"
    fi
    pip install twilio
    #sudo easy_install twilio
}

send_by_curl() {

    curl -X POST https://api.twilio.com/2010-04-01/Accounts/$TWILIO_ACCOUNT_SID/Messages.json \
    --data-urlencode "Body=$body"\
    --data-urlencode "From=+$from" \
    --data-urlencode "To=+$to" \
    -u $TWILIO_ACCOUNT_SID:$TWILIO_AUTH_TOKEN | jq
}

login() {
    sleep 10
    echo
    echo -e "\033[34mCopy your own ACCOUNT SID and AUTH TOKEN from your twilio console to here.\033[0m"
    echo -e "\033[34mAfter that, please run command 'twilio profiles:use profile_name' in here.\033[0m"
    echo
    twilio login
}

main() {
    echo -e "\033[34mInstalling prelibs...\033[0m"
    preinstall
    login
    read_info

    echo -e "\033[36mWhich method would you like to send message by Twilio? [cli, curl]\033[0m"
    read method

    if [ $method == "cli" ]
    then
        send_by_cli
    else
        send_by_curl
    fi
}

main
