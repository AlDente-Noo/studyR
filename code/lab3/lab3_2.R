library(tidyverse)
load("D:GIT/studyR/data/trades.RData")
tb <- trades |>
  bind_rows() |>
  select(-geo) |>
  dplyr::filter(str_detect(indic_et, "Exports in|Imports in")) |>
  pivot_wider(names_from = indic_et, values_from = values) |>
  rename(
    export = "Exports in million of ECU/EURO",
    import = "Imports in million of ECU/EURO"
  )

trades_fdt <- tb |>
  dplyr::filter(str_detect(sitc06, "Food, drinks and tobacco")) |>
  group_by(time) |>
  summarise(export = sum(export), import = sum(import))

colors <- c("Export" = "red", "Import" = "blue")
p <- ggplot(trades_fdt, aes(x = time))
p <- p + geom_line(aes(y = export, color = "Export")) + geom_point(aes(y = export))
p <- p + geom_line(aes(y = import, color = "Import")) + geom_point(aes(y = import))
p <- p + geom_text(aes(y = export, label = export), nudge_x = -85, nudge_y = 850) + geom_text(aes(y = import, label = import), hjust = 0, nudge_x = 50, nudge_y = -150)
p <- p + labs(x = "Time", y = "Value", title = "Export Import FDT", color = "Legend") + scale_color_manual(values = colors)
p <- p + theme(plot.title = element_text(hjust = 0.5))
print(p)
