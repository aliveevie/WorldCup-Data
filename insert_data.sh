#! /bin/bash
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# ADD unique teams first
echo $($PSQL "TRUNCATE teams, games")
echo "$($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART 2")"
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $WINNER != winner  || $OPPONENT != opponent ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID ]]
      then
         INSERT_WINNER=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi

  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
      then
        INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
fi
WINNER_SN=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
OPPONENT_SN=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
INSERT_GAME_VALUES=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_SN, $OPPONENT_SN, $WINNER_GOALS, $OPPONENT_GOALS)")

fi

done





