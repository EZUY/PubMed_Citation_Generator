# Citation_list_generator
### A tool to generate citation with link for reference in [PubMed](https://pubmed.ncbi.nlm.nih.gov/)

### Input
#### Step 1   Save citation to csv file
<img width="571" alt="image" src="https://user-images.githubusercontent.com/36686065/219443875-f7a63a0e-c450-4b64-9c04-110d6262ef7b.png">

You will have a SAVE_CITATION.csv with following format:
| PMID | Title | Authors | Citation | First Author | Journal/Book | Publication Year | Create Date | PMCID | NIHMS ID | DOI |
| ---- | ----- | ------- | -------- | ------------ | ------------ | ---------------- | ----------- | ----- | -------- | --- |

#### Step 2   Run the code with the csv
| Field      | Description |
| ----------- | ----------- |
| csv_pubmed_loc      | The location of csv you get from pubmed save citation in step 1 |
| save_references_name   | The name of saved docx file will be save_references_name.docx or save_references_name_{year}.docx if  seperate_in_year = TRUE |
| bold_Authors   | The Author you want to bold highlight; The order of entry with those authors as first author/ last author will move up in list |
| seperate_in_year  | if TRUE, will generate a list of docx file with save_references_name_{year}.docx; if FALSE, one save_references_name.docx will be generated |
| citation.font  | font of the citation |
| citation.font.size  | font size of the citation |
| citation.link.color  | hyperlink color of the citation |


```r
csv_pubmed_loc = "SAVE_CITATION.csv"
bold_Authors <-
  c("Author A", "Author B")
save_references_name = "referece"
get_citation_doc(
  csv_pubmed_loc,
  save_references_name,
  bold_Authors,
  seperate_in_year = FALSE,
  citation.font = "Garamond",
  citation.font.size = 12,
  citation.link.color = "blue"
)

```

### Output

