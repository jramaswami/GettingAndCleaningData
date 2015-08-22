# Codebook

## Summary
This data is the mean value of the mean and standard deviations
of acceleration data gathered from the smartphones of volunteers
as they performed a variety of activities.

The original acceleration data was gathered by  researchers Jorge L. 
Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto and Xavier 
Parra from the Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa, Italy and
CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya, Vilanova i la Geltrú, Spain.

The researchers gathered data from the accelerometer and gyroscope
of smartphones worn by 30 volunteers while performing six activities:
walking, walking upstairs, walking downstairs, sitting, standing,
and laying.  They divided the data into test and training datasets
for the purposes of their research.  For this project, this division
has been undone and the test and training datasets have been recombined
into one dataset.

Mean and standard deviation values for each type of measurement
were extracted and the mean value calculated.  This summary
data is written to summary.txt.

## Data Dictionary

<table>
<thead>
<tr>
<th>Variable Name</th>
<th>Variable Description</th>
<th>Values or Explanation</th>
</thead>
<tbody>
<tr>
<td>subject</td>
<td>
Numeric id of the subject who wore the cellphone that provided the 
measurements
</td>
<td></td>
<tr>
<td>activity.label</td>
<td>
Description of what the subject was doing when measurement was taken. 
</td>
<td>
<ol>
<li>WALKING</li>
<li>WALKING_UPSTAIRS</li>
<li>WALKING_DOWNSTAIRS</li>
<li>SITTING</li>
<li>STANDING</li>
<li>LAYING</li>
</ol>
</td>
</tr>
<tr>
<td>descriptive.statistic</td>
<td>
Type of descriptive statistic the value represented in the raw data.
</td>
<td>
<ol>
<li>MEAN</li>
<li>STANDARD_DEVIATION</li>
</ol>
</td>
</tr>
<tr>
<td>signal.domain</td>
<td>
The domain of the signal. The data from the original research contained
data from two domains.  First, the researchers labeled raw input 
as time domain signals.
Second, the researches applied a Fast Fourier Transform to calculate
frequency domain signals.
</td>
<td>
<ol>
<li>TIME</li>
<li>FREQUENCY</li>
</ol>
</td>
</tr>
<tr>
<td>acceleration.component</td>
<td>
The component of acceleration.  The researchers original data divided
the acceleration into two components: the gravitational acceleration and
the acceleration of the subject's body.
</td>
<td>
<ol>
<li>BODY</li>
<li>GRAVITY</li>
</ol>
</td>
</tr>
<tr>
<td>acceleration.type</td>
<td>
The type of acceleration.  The researchers original data included measurements
from two devices in the smartphone the subject was wearing: an accelerometer
and a gyroscope.  Measurements from the accelerometer represent the
linear acceleration.  Measurements from the gyroscope represent angular
acceleration.  Researchers also did caclulations to determine the jerk
accleration as well, adding two more types of acceleration measurements:
linear jerk acceleration and angular jerk accleration.
</td>
<td>
<ol>
<li>LINEAR</li>
<li>ANGULAR</li>
<li>LINEAR_JERK</li>
<li>ANGULAR_JERK</li>
</ol>
</td>
</tr>
<tr>
<td>vector.characteristic</td>
<td>
The researchers original data measured the acceleration vector in separate
characteristics: the x direction, the y direction, the z direction, and
the magnitude of the vector.
</td>
<td>
<ol>
<li>X</li>
<li>Y</li>
<li>Z</li>
<li>MAGNITUDE</li>
</ol>
</td>
</tr>
<tr>
<td>mean.value</td>
<td>The mean value of the mean and standard deviation
measurements in the original research data when grouped by:
<ul>
<li>activity.label</li>
<li>descriptive.statistic</li>
<li>signal.domain</li>
<li>acceleration.component</li>
<li>acceleration.type</li>
<li>vector.component</li>
</ul>
</td>
<td></td>
</tr>
</table>

