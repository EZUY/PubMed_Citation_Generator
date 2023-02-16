


library(officer)
library(dplyr)
library(stringr)
user.font = "Garamond"
user.font.size = 12

standard_text <-
  fp_text(font.family = user.font, font.size = user.font.size)
standard_text_bold <-
  fp_text(font.family = user.font,
          font.size = user.font.size,
          bold = TRUE)
standard_hyperlink <-
  fp_text(font.family = user.font,
          font.size = user.font.size,
          color = "blue")

doc_add_reference <- function(doc, paper_info,bold_Authors) {
  Title <- paper_info$Title
  Citation <- paper_info$Citation
  PMID <- paper_info$PMID
  PMCID <- paper_info$PMCID
  Authors <- paper_info$Authors
  NIHMSID <- paper_info$NIHMS.ID
  Authors <- str_split(Authors, ",", simplify = TRUE)
  
  fpar_authors <- c()
  
  paper_reference_pubmed <- lapply(seq(1:length(Authors)),
                                   function(i) {
                                     Author_i <- str_trim(Authors[i])
                                     
                                     
                                     if (Author_i %in% bold_Authors) {
                                       Author_i_style <- standard_text_bold
                                     } else{
                                       Author_i_style <- standard_text
                                     }
                                     if (i != length(Authors)) {
                                       Author_i <- paste0(Author_i, ", ")
                                     } else{
                                       Author_i <- paste0(Author_i, " ")
                                     }
                                     ftext_Author_i <-
                                       ftext(Author_i, prop = Author_i_style)
                                     ftext_Author_i
                                   })

  
  end_index = length(paper_reference_pubmed) + 1
  paper_reference_pubmed[[end_index]] <-
    hyperlink_ftext(
      href = paste0("https://pubmed.ncbi.nlm.nih.gov/", PMID),
      text = paste0(Title, ". "),
      prop = standard_hyperlink
    )
  end_index <- end_index + 1
  paper_reference_pubmed[[end_index]] <-
    ftext(Citation, prop = standard_text)
  end_index <- end_index + 1
  if (!is.na(PMID)) {
    paper_reference_pubmed[[end_index]] <-
      ftext(paste0("; PubMed PMID: ", PMID), prop = standard_text)
    end_index <- end_index + 1
  }
  if (!is.na(PMCID)) {
    paper_reference_pubmed[[end_index]] <-
      ftext(paste0("; PubMed Central PMCID: ", PMCID), prop = standard_text)
    end_index <- end_index + 1
  }
  if (!is.na(NIHMSID)) {
    paper_reference_pubmed[[end_index]] <-
      ftext(paste0("; NIHMSID: ", NIHMSID), prop = standard_text)
    end_index <- end_index + 1
  }
  
  fp <- do.call(fpar,
                paper_reference_pubmed)
  
  
  doc <- body_add_fpar(doc, fp)
  #doc <-  body_add_par(doc, " ")
  doc
}

get_citation_doc <-
  function(csv_pubmed_loc,
           save_references_name,
           bold_Authors,
           seperate_in_year = FALSE) {
    csv_pubmed <- read.csv(csv_pubmed_loc)
    csv_pubmed[csv_pubmed == ""] <- NA
    Authors_order <- c()
    for (i in seq(1:nrow(csv_pubmed))) {
      paper_info <- csv_pubmed[i, ]
      Authors <- paper_info$Authors
      Authors <- str_split(Authors, ",", simplify = TRUE)
      Author_first <- str_trim(Authors[1])
      Author_last <- str_trim(Authors[length(Authors)])
      Author_order <- 3
      if (Author_first %in% bold_Authors) {
        Author_order <- 1
      }
      if (Author_last %in% bold_Authors) {
        Author_order <- 2
      }
      Authors_order <- c(Authors_order, Author_order)
    }
    csv_pubmed$Authors_order <- Authors_order
    
    csv_pubmed <-
      csv_pubmed %>% arrange(-Publication.Year, Authors_order, First.Author)
    
    if (seperate_in_year) {
      for (year in unique(csv_pubmed$Publication.Year)) {
        csv_pubmed_year <- csv_pubmed[csv_pubmed$Publication.Year == year, ]
        doc = read_docx()
        for (i in seq(1:nrow(csv_pubmed_year))) {
          paper_info <- csv_pubmed_year[i, ]
          doc <- doc_add_reference(doc, paper_info, bold_Authors)
        }
        print(doc, target = paste(save_references_name, year, ".docx"))
      }
    } else{
      doc = read_docx()
      for (i in seq(1:nrow(csv_pubmed))) {
        paper_info <- csv_pubmed[i, ]
        doc <- doc_add_reference(doc, paper_info, bold_Authors)
      }
      print(doc, target = paste(save_references_name, ".docx"))
    }
  }
