## Nomenclature

The two pipelines have settled on slightly different nomenclature for key concepts, and it is important to be aware of these differences. The most critical difference to be aware of is the use of the word **session**, which is used in both pipelines to refer to different concepts.

### Language

The pipeline code is written in a mixture of Python and Matlab. 

Documentation is written in English. Where there exist differences in dialects of English, American english is standard, e.g., "color" instead of "colour". 

The pipeline code and database accept text in the Danish unicode format. This supports the standard Danish/Norwegian characters æ ø å, as well as the Swedish variations. Support of other accented Latin characters (e.g. â or ü) have not been tested. No support is provided for non-Latin characters (e.g. greek, cyrillic, etc).

### Date formats

Date formats are generally given in ISO8601 format, i.e. YYYY-MM-DD. For example, November 9 1989 is given as 1989-11-09. Timestamps are typically provided accurate to the second, with missing information automatically filled in as zero. For example, "1989-11-09" will be converted to "1989-11-09 00:00:00"

### Sessions, Metasessions, and Recordings

Both pipelines support a hierarchical grouping of recording activity. The "top-level" grouping os associated with a researcher going into their laboratory in the morning, and leaving in the afternoon or evening. Typically, this is tied to **a single tracking system and recording room**.

| Imaging       | Ephys                 | Explanation |
| ------------- | :-----------         | ----------- |
| Metasession   | Session               | Contains one or more different recording activities |
|               | Recording             | A single, continuous, series of recording data. A new recording is started either if some error or crash occurs, or if the user presses stop/start|
| Session       | Task                  | One specific animal-related activity within the overall grouping. For example, sleeping, or navigating an openfield, or photostim |

