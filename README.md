# LEAP

LEAP is an R package and please see the paper for detailed information: [LEAP: Constructing Gene Co-Expression Networks for Single-Cell RNA-Sequencing Data Using Pseudotime Ordering](https://academic.oup.com/bioinformatics/article/33/5/764/2557687)

## Installation

```{r}
if (!require("pak")) {
    install.packages("pak")
}
pak::pak("mengxu98/LEAP")
```

## Citations

```
@article{10.1093/bioinformatics/btw729,
    author = {Specht, Alicia T and Li, Jun},
    title = "{LEAP: constructing gene co-expression networks for single-cell RNA-sequencing data using pseudotime ordering}",
    journal = {Bioinformatics},
    volume = {33},
    number = {5},
    pages = {764-766},
    year = {2016},
    month = {12},
    doi = {10.1093/bioinformatics/btw729},
    url = {https://doi.org/10.1093/bioinformatics/btw729}
}
```

## Note

The R package is just re-built by me, if you have any questions, please contact orginal author: [Alicia T. Specht](aspecht2@nd.edu).
