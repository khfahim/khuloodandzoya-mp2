```{r}
install.packages("naniar")
```

```{r}
library(tidyverse)
library(naniar)
load("house_elections.rda")
load("candidates.rda")
load("committees.rda")
load("contributions.rda")
```

```{r}
first_jim <- candidates %>%
  filter(cand_id == "H8WA07132")
first_jim
```

```{r}
first_jim <- first_jim %>%
  select(cand_id, cand_name, cand_party_affiliation, cand_office_state) %>%
  inner_join(committees, by = "cand_id")
first_jim
```

```{r}
committees %>%
  group_by(cand_id) %>%
  summarise(n = n_distinct(cmte_name)) %>%
  arrange(desc(n)) %>%
  head(10)
```

```{r}
committees
```


```{r}
first_committee <- committees %>%
  select(cmte_id, cmte_name, cmte_state, cmte_party_affiliation, org_type, cand_id) %>%
  filter(!cand_id== "", !org_type== "")
first_committee
```

```{r}
first_candidate <- candidates %>% 
  select(cand_id, cand_name, cand_party_affiliation, cand_state, cand_office) %>%
  inner_join(first_committee, by = "cand_id")
first_candidate %>%
  filter(!org_type== "", !cand_id== "")
```



```{r}
new_table <- inner_join(candidates, contributions, by= "cand_id")
```


```{r}
MP2_table <- inner_join(new_table, committees, by= "cand_id") %>%
  select(cand_id, cand_name, cand_party_affiliation, cand_state, cmte_name, cmte_state, connected_org_name)
```

```{r}
new_house <- house_elections %>%
  rename("cand_id"= fec_id)
new_house 
```


```{r}
new_table <- inner_join(MP2_table, new_house, by= "cand_id") %>%
  group_by(cand_name)
```


```{r}
contributions <- contributions %>%
  select(name, state, cand_id)
```
