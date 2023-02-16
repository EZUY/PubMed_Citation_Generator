# Citation_list_generator
### A tool to generate citation with link for reference in [PubMed](https://pubmed.ncbi.nlm.nih.gov/)


## Step 1   Save citation to csv file
<img width="571" alt="image" src="https://user-images.githubusercontent.com/36686065/219443875-f7a63a0e-c450-4b64-9c04-110d6262ef7b.png">

You will have a SAVE_CITATION.csv with following format:
| PMID | Title | Authors | Citation | First Author | Journal/Book | Publication Year | Create Date | PMCID | NIHMS ID | DOI |
| ---- | ----- | ------- | -------- | ------------ | ------------ | ---------------- | ----------- | ----- | -------- | --- |

## Step 2   Run the code with the csv
| Field      | Description |
| ----------- | ----------- |
| csv_pubmed_loc      | The location of csv you get from pubmed save citation in step 1 |
| bold_Authors   | The Author you want to bold highlight;        |


```r
csv_pubmed_loc = "SAVE_CITATION.csv"
bold_Authors <-
  c("Author A", "Author B")
save_references_name = "referece"
get_citation_doc(
  csv_pubmed_loc,
  save_references_name,
  bold_Authors,
  seperate_in_year = TRUE,
  citation.font = "Garamond",
  citation.font.size = 12,
  citation.link.color = "blue"
)

```
