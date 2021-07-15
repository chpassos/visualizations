# Gantt visualization in R
library(tidyverse)

# Building data
df <-
    data.frame(
        task = c(
            "História e Distribuição da Mutação",
            "Padrões de Endocruzamento",
            "Simulações",
            "Revisão Bibliográfica",
            "Publicação dos Resultados"
        ),
        start = c(
            "2021-07-01",
            "2022-01-01",
            "2022-06-01",
            "2021-07-01",
            "2023-06-01"
        ),
        end = c(
            "2022-06-01",
            "2022-12-31",
            "2023-06-01",
            "2023-06-01",
            "2023-07-01"
        ),
        type = c(
            "Análise",
            "Análise",
            "Análise",
            "Literatura e Produção Científica",
            "Literatura e Produção Científica"
        )
    )


# Transforming datastime format
df <- df %>%
    mutate(start = as.Date(start), end = as.Date(end))


# Tidying data
df_tidy <- df %>%
    pivot_longer(c(start, end), names_to = "data_type", values_to = "date")


# Viz --
pal <- c("#59679C", "#E8D49B")

# Gantt plot
ggplot(df_tidy) +
    geom_line(aes(fct_rev(fct_inorder(task)), date, color = type), size =
                  10) +
    geom_hline(
        yintercept = as.Date("2022-01-01"),
        colour = "black",
        linetype = "dashed",
        alpha = 0.5
    ) +
    geom_hline(
        yintercept = as.Date("2023-01-01"),
        colour = "black",
        linetype = "dashed",
        alpha = 0.5
    ) +
    scale_color_manual(values = pal) +
    coord_flip() +
    labs(title = "Plano de Trabalho e Cronograma",
         x = "Tarefas",
         y = "Data") +
    theme_classic() +
    theme(
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5),
        aspect.ratio = .3
    )
