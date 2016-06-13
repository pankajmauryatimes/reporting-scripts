#!/bin/bash

mysql -udwhuser -pdwhuser tjdwh_db < /home/dwhuser/tjdwh/bin/sql/mv_update_last_login_date.sql > /home/dwhuser/tjdwh/bin/sql/log/mv_update_last_login_date.log

mysql -udwhuser -pdwhuser tjsitestats < /home/dwhuser/tjdwh/bin/sql/tjr_daily_aggregarions.sql > /home/dwhuser/tjdwh/bin/sql/log/tjr_daily_aggregarions.log

exit


