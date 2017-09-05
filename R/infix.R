library(dplyr)

#' @title partial evaluation
#' @description partial evaluation of function, consistant with dplyr first param
#' @export
#' @param f function
#' @param ... loaded partial parameters after first param
#' @return g <- function(X) f(X, ...)
partial = function(f, ...) function(X) f(X, ...)

#' @title Not In
#' @description infix 'Not In' function
#' @export
#' @return boolean
'%ni%' = Negate(`%in%`)

#' @title string concatination
#' @description infix string concatination
#' @export
#' @param x string
#' @param y string
#' @return string
'%&%'   = function(x, y)paste0(x,y)

#' @title function composition
#' @description compose functions with single parameter
#' @export
#' @param f function with one input parameter
#' @param g function with one input parameter
#' @return function
#' @name infixcompose
#' @rdname infixcompose
'%|%' = function(f, g) function(X) X %>% f %>% g

#' @title infix T Pipe
#' @description Takes a list of functions to apply to an input
#' @export
#' @param d data to pass into funcs
#' @param funcs named list of functions that take data in same form of d
#' @return list of results, preserving names
#' @usage c(1,2,3) %T% list(first=partial(head, n=1), last=partial(tail, n=1))
'%T%'  = function(d, funcs)
  lapply(funcs, partial(function(f, d) f(d), d))

#' @title infix lapply
#' @description infix lapply
#' @export
#' @param l list of inputs
#' @param f function to apply accross list
#' @return list of return values
#' @usage c(1,2,3) %T>% function(x) {return(x ** 2)}
'%T>%' = function(l, f) lapply(l, f)

########################

#' @title draw_rownames
#' @description to make dataframes more tibble compatible by saving rownames to column
#' @export
#' @param .data dataframe with rownames
#' @return tibble
draw_rownames <- function(.data) .data %>%
  do(mutate(.,"rownames"=rownames(.)))

#' @title dropcols
#' @description unselect columns by name
#' @export
#' @param .data dataframe with rownames
#' @return tibble
dropcols = function(df, cols) df[,colnames(df) %ni% cols]
