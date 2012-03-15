## Tracking flight delays with bts data

The [Bureau of Transportation Statistics](http://www.bts.gov/) collects information on transportation statistics (duh)--for our purposes they provide information on flight times, passenger (and airframe) loading, and other flight characteristics. This free resource can help us build a model to predict when and where delays will arise and determine which delays are avoidable and which (non-maintenance and non-weather) delays are likely to be unconnceted to structural constraints. 

In order to do this we have to import, parse and otherwise make sense of medium size data (~500,000 rows per month).

At the moment there is no easy programmatic way to download monthly data from bts. Lots of clicking radio buttons and loading dynamically generated pages. 

## Scripts

### time.pl

Import script to clean up data downloaded from the bts applet. Will eventually be expanded to report column names, number of rows, etc. in order to simplify and (greatly) speed up importing data with read.table

### ontime.R

Performs the meat of the importing trouble. Generates factor variables (by converting from binary factors to character factors, see [here](https://gist.github.com/2038145)), converts time to minutes past midnight in local time, and does some other housekeeping.

Eventually local time will be converted to UTC but for now minutes is the most nuisance free format, allowing arithmetic and quick conversion to factors.

Relatively stable and can be used for any month, but depends on knowing the number, type and order of columns of the incoming csv. This will be improved over time.

### ontime.ggplot.R

With ggplot 0.9.0, we can plot quickly enough to use ggplot for prototyping as well as final display. This file is in flux and may not work out of the box for all datasets. 