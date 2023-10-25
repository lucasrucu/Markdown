### Links

To link a website or external link in markdown you can use the following format:

```markdown
[This is a link](https://www.google.com/search?q=youtube+rickrolled&oq=youtube+rickrolled&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORiABDIICAEQABgWGB4yCAgCEAAYFhgeMggIAxAAGBYYHjIGCAQQRRhAMgYIBRBFGEDSAQgzNTA5ajBqMagCALACAA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:d7b50f1f,vid:dQw4w9WgXcQ,st:0)
```

The result should look like this

[This is a link](https://www.google.com/search?q=youtube+rickrolled&oq=youtube+rickrolled&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORiABDIICAEQABgWGB4yCAgCEAAYFhgeMggIAxAAGBYYHjIGCAQQRRhAMgYIBRBFGEDSAQgzNTA5ajBqMagCALACAA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:d7b50f1f,vid:dQw4w9WgXcQ,st:0)

### Local Links

### Images

To reference an image that exists in the vault, you can use the same link format but add a *!*.

```markdown
[Image](../Assets/Images/db_architecture.mapper.png)
```

![Image](/Assets/Images/db_architecture.mapper.png)

### Formulas

$$VAC = -Inversion + \sum_{t=1}^n \frac{FC_t}{(1 + COK)^t}$$

This is a good place to see more about markdown formulas: [Mathematical Notations in Obsidian](https://www.makeuseof.com/write-mathematical-notation-obsidian/#:~:text=Thanks%20to%20MathJax%2C%20you%20can,%24%24%20dedicates%20an%20entire%20line)

### HTML

You can use html in order to make custom tables, insert images too, and give the styles.

```html
<p style="color: Red">Hello</p>

<img src="../Assets/Images/db_architecture.mapper.png" width="100px">

<table border="1">
 <tr>
  <td rowspan="2">&nbsp;This is a merged cell</td>
  <td width="200px">&nbsp;This is a cell</td>  
  <td>&nbsp;This is a cell</td>
 </tr>
 <tr>
  <td height="50px">&nbsp;This is a cell</td>
  <td>&nbsp;This is a cell</td>
 </tr>
 <tr>
  <td>&nbsp;This is a cell</td>
  <td colspan="2">&nbsp;This is a merged cell</td>
 </tr>
</table>
```

Output:
<p style="color: Red">Hello</p>
<img src="../Assets/Images/db_architecture.mapper.png" width="100px">

> En este caso la imagen no se muestra en obsidian, pero en Github se puede visualizar con los estilos que le pongas a la imagen.

<table border="1" style="border-color: red">
 <tr>
  <td rowspan="2">&nbsp;This is a merged cell</td>
  <td width="200px">&nbsp;This is a cell with width</td>  
  <td style="padding: 20px; color: red">&nbsp;This is a cell with padding</td>
 </tr>
 <tr>
  <td height="80px">&nbsp;This is a cell with height</td>
  <td>&nbsp;This is a cell</td>
 </tr>
 <tr>
  <td>&nbsp;This is a cell</td>
  <td colspan="2" style="padding: 10px; border: 1px solid blue;">&nbsp;This is a merged blue cell</td>
 </tr>
</table>

> La configuración de los estilos para la tabla, el color, padding, solo se puede visualizar en obsidian, en Github no se ve.