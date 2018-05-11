Code Style And Directory Structure
===

## Directory Structure

It is composed mainly of the following folders:
* app: user app folder
* demo: examples
* include: header files
* init: initilize code, do not edit
* platform: lib files

You can find API in `include` folder, and examples in `demo` folder.

All the event and it's parameters description from lower system can be find in `api_event.h`

## Coding Style

A unified code style and convenient reading is very important for any code, each person's code style is different, but many people must have a unified style when developing the same project, and a simple and clean code will make the code more smooth and easy.

CSDK uses a unified code style to briefly summarize the following points:

### Function naming

Module API uses a `"upper case function module name"+"_"+"Upper Camel Case"`," such as `AUDIO_MicOpen`, `SSL_Init`; the ordinary function is named with `Upper-Camel-Case`, such as `EventDispatch`.

> entry function is special, use the folder name _Main`, for example, `imei_Main`.

### Variable naming

Lower camel case, e.g.:`int ballNumber;`

### Macro definition

Upper case with"`_`", e.g.: `#define BUFFER_MAX_LENGTH 10`

### File Encoding Format

File use `UTF-8` with no BOM format

### Tab Or Space

Use 4 space instead of <kbd>tab</kbd>

### Word abbreviation

* use acronyms for some well-known words in the industry, such as `src`, `tmp`,`addr`, etc.

* in addition to this, in order to ensure the readability of the code, be sure to use the full name, especially some professional terms, to make the person without contact with the word search the meaning of the word through the search engine.

For example, `NetworkLocation`, if abbreviated to `NL`, `NetLo`, believe that even people who are very familiar with the word have to look at the context of the code to get the meaning of it slowly! If you search these abbreviations on the Internet, you never get `NetworkLocation`!

**so, in order to make the code more concise and easy to read, it is not necessarily to make the code words abbreviated to a simpler form, but the opposite is that the full-name words are often more readable.**

In addition, some words need to be interpreted and appropriate comments should be made.

### Comment

annotations can be used with / * * / \ "or / / \" to annotate, and invalid code should be used as / (* * / \ "notes) as far as possible.

* User `/**/` or `//` to comment code, and invalid code should be comment with `/**/` as far as possible.

* If we want some comment added to auto generated documentation, use:

```
//////////////
///comment here
//////////////
```

of

```
/**
  *comment here
  *
  */
```

* And add some infomation to file or function, e.g. file:

```
/**
  *@file header.h
  *@author nick name
  */
```
or function
```
/**
  *@brief brief, @brief can be omitted
  *@param a parameter a
  *@param b parameter b
  *@return  return sum
  */
```


