# Automate GIMP
### Requirements

- python
- gimp-python

### Usage
Open main.sh fill TITLE and SUBTITLE variables.

```bash
bash main.sh -f path/file.xcf
```

It will generate a PNG image file.png changing the content of the first two layers containing a TEXT layer with TITLE and SUBTITLE (variable in the main.sh file).
