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
![Image](/Assets/Images/db_architecture.mapper.png)
```

![Image](/Assets/Images/db_architecture.mapper.png)

### Formulas

$$VAC = -Inversion + \sum_{t=1}^n \frac{FC_t}{(1 + COK)^t}$$

This is a good place to see more about markdown formulas: [How to Write Mathematical Notations in Obsidian (makeuseof.com)]("https://www.makeuseof.com/write-mathematical-notation-obsidian/#:~:text=Thanks%20to%20MathJax%2C%20you%20can,%24%24)%20dedicates%20an%20entire%20line".

### HTML

You can use html in order to make custom tables, insert images too, and give the styles.
```html
<p style="color: Red">Hello</p>
```

Output: <p style="color: Red">Hello</p>
