# Codebook

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
<td>input.type</td>
<td>
The type of input. The data from the original research contained
two types of input.  First, the researchers labeled raw input 
as "time" input.
Second, the researches applied a Fast Fourier Transform to input as well.
</td>
<td>
<ol>
<li>TIME</li>
<li>FAST_FOURIER_TRANSFORM</li>
</ol>
</td>
</tr>
<tr>
<td>acceleration.component</td>
<td>
The component of acceleration.  The researchers original data divided
the acceleration into two components: the gravitational acceleraton and
an estimated value of the acceleration of the subject's body.
</td>
<td>
<ol>
<li>ESTIMATED_BODY</li>
<li>GRAVITY</li>
</ol>
</td>
</tr>
<tr>
<td>acceleration.type</td>
<td>
The type of acceleration.  The researches original data included measurements
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
<td>
</tr>
</table>





vector.characteristic

mean.value
