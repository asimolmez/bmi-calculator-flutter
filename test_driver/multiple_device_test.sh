#!/bin/sh
LOG_FILE_PATH="test_driver/test_output/"
CURRENT_DEVICE_FILE_NAME="${LOG_FILE_PATH}current_device"
echo ""
echo "FLUTTER UI TEST AUTOMATION STARTED"
sleep 1

echo ""
echo "GETTING CONNECTED DEVICES"
sleep 1
IFS=$'\n'      # Change IFS to new line
CONNECTED_DEVICES=( `flutter devices | grep -- 'ios\|android' | sed 's/ * •.*//'` )
CONNECTED_DEVICES_LENGTH=${#CONNECTED_DEVICES[@]}

if [ CONNECTED_DEVICES_LENGTH == 0 ]; then
    echo " "
    echo "NO CONNECTED DEVICES / Aborting..."
    echo " "
    exit -1
fi

echo ""
echo "AVAILABLE DEVICES TO TEST"
echo "================================="

for (( i=0; i<=$(( $CONNECTED_DEVICES_LENGTH -1 )); i++ ))
do
    echo "$((i+1))) ${CONNECTED_DEVICES[$i]}"
done
echo ""
sleep 1

read -p "CONTINUE AND TEST ALL LISTED DEVICES ABOVE? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

for (( i=0; i<=$(( $CONNECTED_DEVICES_LENGTH -1 )); i++ ))
do
    echo "TEST STARTED ON ==> ${CONNECTED_DEVICES[$i]}" | tee -a "${LOG_FILE_PATH}${CONNECTED_DEVICES[$i]}_log.txt"
    echo "${CONNECTED_DEVICES[$i]}" > $CURRENT_DEVICE_FILE_NAME
    flutter drive --target=test_driver/app.dart -d ${CONNECTED_DEVICES[$i]} | tee -a "${LOG_FILE_PATH}${CONNECTED_DEVICES[$i]}_log.txt"
    echo "TEST FINISHED ON ==> ${CONNECTED_DEVICES[$i]}" | tee -a "${LOG_FILE_PATH}${CONNECTED_DEVICES[$i]}_log.txt"
done

echo ""
echo "FLUTTER UI TEST AUTOMATION COMPLETED"

