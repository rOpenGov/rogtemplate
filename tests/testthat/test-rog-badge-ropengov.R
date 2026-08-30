test_that("rog_badge_ropengov() prints reusable badge Markdown", {
  messages <- capture.output(
    result <- rog_badge_ropengov(install = FALSE),
    type = "message"
  )

  expect_null(result)
  expect_match(messages[1], "Markdown for the badge")
  expect_match(messages[2], "ropengov-badge[.]svg")
  expect_match(messages[2], "https://ropengov[.]org")
})
