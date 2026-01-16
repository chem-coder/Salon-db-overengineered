#! /bin/bash
PSQL="psql -X --username=Dalia --dbname=salon_v1 -t --csv -c"
PSQL2="psql -X --username=Dalia --dbname=salon_v1 -c"
echo -e "\n~~~~~ FANCY CUTS ~~~~~\n"

MAIN_MENU() {
	if [[ $1 ]]
	then
		echo -e "$1"
	fi

	echo -e "How may I help you?\n"
	echo "1) Make an appointment"
	echo "2) Cancel an appointment"
	echo "3) Get a price list"
	echo "4) Leave"
	read MAIN_MENU_SELECTION
	VALIDATE_INPUT $MAIN_MENU_SELECTION 4

	case $MAIN_MENU_SELECTION in
		1) MAKE_APPT ;;
		2) CANCEL_APPT ;;
		3) PRICE_LIST ;;
		4) EXIT ;;
		*) MAIN_MENU "Sorry, I didn't understand." ;;
	esac
}

MAKE_APPT() {
	echo -e "Would you like to\n1) schedule a service, or\n2) schedule with a stylist?"
	read SCHEDULE_OPTION
	VALIDATE_INPUT $SCHEDULE_OPTION 2

	if [[ "$SCHEDULE_OPTION" == 1 ]]
	then
		echo -e "Choose a service:"
		# get services
		$PSQL "SELECT service_id, name FROM services" | while IFS=',' read -r SERVICE_ID SERVICE_NAME
		do
			echo -e "$SERVICE_ID) $SERVICE_NAME"
		done
		
		read SELECTED_SERVICE_ID
		VALIDATE_INPUT $SELECTED_SERVICE_ID 5
		SELECTED_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SELECTED_SERVICE_ID'")
		SCHEDULE_SERVICE

	elif [[ "$SCHEDULE_OPTION" == 2 ]]
	then
		echo -e "Choose a stylist:"
		#get_stylists
		$PSQL "SELECT stylist_id, name FROM stylists" | while IFS=',' read -r STYLIST_ID STYLIST_NAME
		do
			echo -e "$STYLIST_ID) $STYLIST_NAME"
		done
		
		read SELECTED_STYLIST_ID
		VALIDATE_INPUT $SELECTED_STYLIST_ID 5
		SELECTED_STYLIST_NAME=$($PSQL "SELECT name FROM stylists WHERE stylist_id='$SELECTED_STYLIST_ID'")
		SCHEDULE_STYLIST
	else
		MAIN_MENU "Sorry, I didn't understand."
	fi
}

VALIDATE_INPUT() {
	if [[ ! $1 =~ ^[0-9]+$ || $1 < 1 || $1 > $2 ]]  # if the input is NOT a number
	then
		MAIN_MENU "Please, select a valid option - see left-side labels\n"
	else
		echo "" # "Input - good"
	fi
}

SCHEDULE_SERVICE() {
	# choose stylist
	STYLISTS_MENU=$($PSQL2 "SELECT st.stylist_id, st.name, ss.price
	FROM stylist_services ss
	JOIN services s ON s.service_id = ss.service_id
	JOIN stylists st ON st.stylist_id = ss.stylist_id
	WHERE s.service_id='$SELECTED_SERVICE_ID'
	ORDER BY st.stylist_id")

	echo -e "\nChoose a stylist for your $SELECTED_SERVICE_NAME: \n"
	echo -e "$STYLISTS_MENU\n"

	read SELECTED_STYLIST_ID

	COUNT=$($PSQL "SELECT COUNT(*)
	FROM stylist_services ss
	JOIN services s ON s.service_id = ss.service_id
	JOIN stylists st ON st.stylist_id = ss.stylist_id
	WHERE s.service_id='$SELECTED_SERVICE_ID'")
	# echo -e "Stylists count: $COUNT"

	VALIDATE_INPUT $SELECTED_STYLIST_ID $COUNT
	SELECTED_STYLIST_NAME=$($PSQL "SELECT name FROM stylists WHERE stylist_id='$SELECTED_STYLIST_ID'")

	if [[ -z CUSTOMER_ID ]]
	then
		GET_CUSTOMER_INFO
	fi
	ADD_APPT
}

SCHEDULE_STYLIST() {
	# choose service
	SERVICES_MENU=$($PSQL2 "SELECT s.service_id, s.name, ss.price
	FROM stylist_services ss
	JOIN services s ON s.service_id = ss.service_id
	JOIN stylists st ON st.stylist_id = ss.stylist_id
	WHERE st.stylist_id='$SELECTED_STYLIST_ID'
	ORDER BY s.service_id")

	echo -e "\nChoose a service from $SELECTED_STYLIST_NAME: \n"
	echo -e "$SERVICES_MENU\n"

	read SELECTED_SERVICE_ID

	COUNT=$($PSQL "SELECT COUNT(*)
	FROM stylist_services ss
	JOIN services s ON s.service_id = ss.service_id
	JOIN stylists st ON st.stylist_id = ss.stylist_id
	WHERE st.stylist_id='$SELECTED_STYLIST_ID'")
	# echo -e "Services count: $COUNT"

	VALIDATE_INPUT $SELECTED_SERVICE_ID $COUNT
	SELECTED_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SELECTED_SERVICE_ID'")

	if [[ -z CUSTOMER_ID ]]
	then
		GET_CUSTOMER_INFO
	fi
	ADD_APPT
}

GET_CUSTOMER_INFO() {
	# get customer phone number
	echo -e "What's your phone number?"
	read CUSTOMER_PHONE

	# check by ph number whether customer is in the db
	CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

	# if not, ask their name & add to db
	if [[ -z $CUSTOMER_NAME ]]
	then
		echo -e "\nI don't have a record for that phone number, what's your name?"
		read CUSTOMER_NAME
		NEW_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
	fi

	# return customer_id
	if [[ -n "$CUSTOMER_NAME" && -n "$CUSTOMER_PHONE" ]]
	then
		CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
	fi
}

ADD_APPT() {
	# ask for appt time
	echo -e "\nWhat time would you like your $SELECTED_SERVICE_NAME, $CUSTOMER_NAME?"
	read APPT_TIME
	
	# record appt info
	APPT=$($PSQL "INSERT INTO appointments(stylist_id, service_id, time) 
	VALUES ($SELECTED_STYLIST_ID, $SELECTED_SERVICE_ID, '$APPT_TIME')")

	# notify customer
	echo -e "\nI have put you down for a $SELECTED_SERVICE_NAME with $SELECTED_STYLIST_NAME at $APPT_TIME, $CUSTOMER_NAME."

	EXIT
}

CANCEL_APPT() {

	if [[ -z CUSTOMER_ID ]]
	then
		GET_CUSTOMER_INFO
	fi

	# lookup all the customer's appointments
	echo -e "Here is a list of $CUSTOMER_NAME's appointments:"
	CUSTOMERS_APPTS=$($PSQL2 "SELECT a.appointment_id, s.name, st.name, a.time
	FROM appointments a 
	JOIN services s ON s.service_id = a.service_id
	JOIN stylists st ON st.stylist_id = a.stylist_id
	ORDER BY a.appointment_id")
	echo -e "$CUSTOMERS_APPTS\n"

	# ask which one to delete
	echo -e "Which appointment would you like to cancel?"
	read CANCEL_APPT_ID
	VALIDATE_INPUT $CANCEL_APPT_ID 1

	# remove appt info
	$PSQL "DELETE FROM appointments WHERE appointment_id = $CANCEL_APPT_ID"

	# notify customer
	echo -e "Your $APPT_TIME appointment with $SELECTED_STYLIST_ID has been canceled."	

	# exit
	EXIT
}

PRICE_LIST() {
	PRICES=$($PSQL2 "SELECT s.name, st.name, ss.price
	FROM stylist_services ss
	JOIN services s ON s.service_id = ss.service_id
	JOIN stylists st ON st.stylist_id = ss.stylist_id
	ORDER BY s.name, ss.price")

	echo -e "$PRICES\n"
	MAIN_MENU
}

EXIT() {
	echo -e "\nThank you for stopping in!\n"
	exit 0
}

MAIN_MENU "Welcome to Fancy Cuts!"
EXIT
