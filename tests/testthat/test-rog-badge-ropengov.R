test_that("rog_badge_ropengov() prints reusable badge Markdown", {
  messages <- capture.output(
    rog_badge_ropengov(install = FALSE),
    type = "message"
  )

  expect_null(suppressMessages(rog_badge_ropengov(install = FALSE)))
  expect_match(messages[1], "Markdown for the badge")
  expect_match(messages[2], "ropengov-badge[.]svg")
  expect_match(messages[2], "https://ropengov[.]org")
})
