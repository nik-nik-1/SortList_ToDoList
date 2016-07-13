# SortList_ToDoList

<ul style="list-style-type: circle;">
<li>my first Projects :)</li>
<li>generic interface to display TableView, CollectionView screen and some Weather (JSON parsing) in the city (this Projects here superfluous in the sense of - but left "for training")</li>
</ul>


What's interesting here?:

<ol>
<li>MVC</li>
<li>Switching between views (List/Grid) of CollectionView (using <i>"UICollectionViewFlowLayout"</i> subslass)</li>
<li>2 projejc in 1</li>
<li>CoreData (work with 2 different projects)</li>
<li>Plist</li>
<li>Load & using different variant of color from file: <i>"ColorsChoise.plist"</i></li>
<li>Custom cell (<i>"*.xib"</i>- files)</li>
<li>parsing JSON</li>
<li>Custom cell animation (using <i>"CATransform3D"</i>)</li>
<li>Using <i>NSDate</i> ("calculate used time", & ..) </li>
<li>Using <i>UIAlertController<i> </li>
<li>Added custom button to remove the cell in <i>CollectionView</i> </li>
<li>An opportunity to display the current cell in the <i>CollectionView</i> </li>
<li>Extension of <i>UIView</i> to manage the UIBorders of elements via Storyboard (see in the file <i>"UIView_Borders.swift"</i>); by using "@IBInspectable" of some UI-parameters </li>
<li>Has been tested using <a href="https://github.com/realm/SwiftLint">SwiftLint</a></li>
</ol>


<table border="0" width="99%" cellpadding="1" align="left" cellspacing = "2">
<tbody>

<tr align="left">
    <th><i>1. main screen</i></th>
    <th><i>2. list of elements in table view</i></th>
    <th><i>3. "edit" button pressed</i></th>
</tr>

<tr>
<td width="33%><a href="http://piccy.info/view3/10045857/4afb0521a031f888aec9f4b4b51d4dca/" target="_blank"><img src="http://i.piccy.info/i9/77e8a39bf53e0bf9984acc8c46672e60/1468401689/7822/1049505/SortList_ToDoList_S1_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" height="100%" width="100%" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-21/i9-10045857/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-21/i9-10045857/281x500-r/i.gif" alt="" border="0"  /></a></td>
<td width="33%><a href="http://piccy.info/view3/10045860/32d2d4d85aff5703f536460d908de748/" target="_blank"><img src="http://i.piccy.info/i9/3fa51ee02051ff385b31d072a3d2a89a/1468401718/26978/1049505/SortList_ToDoList_S2_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" height="100%" width="100%" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-21/i9-10045860/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-21/i9-10045860/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><a href="http://piccy.info/view3/10045867/c34e06dc9993c147a24fa7685d4dfe03/" target="_blank"><img src="http://i.piccy.info/i9/f2c5baac59d4d87b817d8f252683e0cc/1468401764/30075/1049505/SortList_ToDoList_S3_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" height="100%" width="100%"/></a><a href="http://i.piccy.info/a3c/2016-07-13-09-22/i9-10045867/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-22/i9-10045867/281x500-r/i.gif" alt="" border="0" /></a></td>
</tr>

<tr align="left">
    <th><i>4. detail screen</i></th>
    <th><i>5. сolor picker menu</i></th>
    <th><i>6. action sheet menu (press "..." in cell to call)</i></th>
</tr>
<tr align="justify">
<td width="33%><a href="http://piccy.info/view3/10045870/14f9355ce775d127824bb244e1a011cd/" target="_blank"><img src="http://i.piccy.info/i9/6245d7829540433978b5254b098124c9/1468401805/10029/1049505/SortList_ToDoList_S4_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-23/i9-10045870/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-23/i9-10045870/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><a href="http://piccy.info/view3/10045878/554db6ff632253ea75b68eddadb480df/" target="_blank"><img src="http://i.piccy.info/i9/ec9d694a597a7fbbfe08730f4b84f81e/1468401914/11723/1049505/SortList_ToDoList_S5_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-25/i9-10045878/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-25/i9-10045878/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><em></em><a href="http://piccy.info/view3/10045891/60fd9721ac94b58c0454c4ba28111b4b/" target="_blank"><img src="http://i.piccy.info/i9/f226225d4f42d2988b1dfcd01d986edf/1468402086/19096/1049505/SortList_ToDoList_S7_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-28/i9-10045891/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-28/i9-10045891/281x500-r/i.gif" alt="" border="0" /></a></td>
</tr>

<tr align="left">
    <th><i>7. collection view (Grid)</i></th>
    <th><i>8. collection view (List)</i></th>
    <th><i>9. short video (switching between List&amp;Grid views in collection)</i></th>
</tr>

<tr align="justify">
<td width="33%><em></em><a href="http://piccy.info/view3/10045903/3976b61c86cadf3d0901041df6539e7e/" target="_blank"><img src="http://i.piccy.info/i9/bdee26493280b63d42dffb9014a0be90/1468402197/28082/1049505/SortList_ToDoList_S6_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-29/i9-10045903/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-29/i9-10045903/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><em></em><a href="http://piccy.info/view3/10045908/b49d5e1564fc29ed2cd3815218c6d03e/" target="_blank"><img src="http://i.piccy.info/i9/013d174e4d812ba0a3c62d59708a3e51/1468402235/27919/1049505/SortList_ToDoList_S10_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-30/i9-10045908/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-30/i9-10045908/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><em></em>

 <a href="http://www.youtube.com/watch?feature=player_embedded&v=wrI-5zaqZRs
" target="_blank"><img src="http://img.youtube.com/vi/wrI-5zaqZRs/0.jpg" 
alt="" height="100%" width="100%" border="1" /></a>
  
</td>
</tr>


<tr align="left">
    <th><i>10. delete cell in collection (Grid)</i></th>
    <th><i>11. delete cell in collection (List)</i></th>
    <th><i>12. show active cell in collection</i></th>
</tr>

<tr align="justify">
<td width="33%><em></em><a href="http://piccy.info/view3/10045912/9977f4015d03ecd329c50e415005010d/" target="_blank"><img src="http://i.piccy.info/i9/ec2f2755195633a88faf794b4bde20c6/1468402292/30488/1049505/SortList_ToDoList_S9_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-31/i9-10045912/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-31/i9-10045912/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><em></em><a href="http://piccy.info/view3/10045921/f39559e8d2cb341efee0b16bbde738f5/" target="_blank"><img src="http://i.piccy.info/i9/baf5f8efde1e93a407da669026222968/1468402391/29069/1049505/SortList_ToDoList_S11_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-33/i9-10045921/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-33/i9-10045921/281x500-r/i.gif" alt="" border="0" /></a></td>
<td width="33%><em></em><a href="http://piccy.info/view3/10045923/27259142675882e13b61b723c97ceecf/" target="_blank"><img src="http://i.piccy.info/i9/55c57b28dccf3c6e0f1a67ee69f0a718/1468402457/28682/1049505/SortList_ToDoList_S8_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-34/i9-10045923/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-34/i9-10045923/281x500-r/i.gif" alt="" border="0" /></a></td>
</tr>

<tr align="left">
    <th><i>13. weather view</i></th>
</tr>

<tr align="justify">
<td width="33%><em></em><a href="http://piccy.info/view3/10045931/45985d32b37381a976cc0c380afca620/" target="_blank"><img src="http://i.piccy.info/i9/9a78707fb8fe1cc98fd21b1e6fed5636/1468402537/22990/1049505/SortList_ToDoList_S12_500.jpg" alt="Piccy.info - Free Image Hosting" border="0" /></a><a href="http://i.piccy.info/a3c/2016-07-13-09-35/i9-10045931/281x500-r" target="_blank"><img src="http://i.piccy.info/a3/2016-07-13-09-35/i9-10045931/281x500-r/i.gif" alt="" border="0" /></a></td>
</tr>
</tbody>
</table>
