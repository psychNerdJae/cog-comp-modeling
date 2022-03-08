#### Risk/ambiguity utility ####

compute_utility_risk_amb <- function(
  agent_alpha, agent_beta, gamble_value, gamble_win_prob, gamble_amb
) {
  # Check for mistakenly-typed risk/ambiguity
  if (!between(gamble_win_prob, 0, 1) | !between(gamble_amb, 0, 1)) {
    stop("The gamble risk/ambiguity must fall in [0, 1].")
  }
  
  # Check whether risk level is appropriate, given ambiguity level
  if (gamble_amb != 0 & gamble_win_prob != 0.5) {
    warning("Non-zero ambiguity level specified. Risk level changed to 50%.")
    gamble_win_prob <- 0.5
  }
  return (
    (gamble_value^agent_alpha) * (gamble_win_prob + (agent_beta * gamble_amb / 2))
  )
}


#### Reinforcement learning ####

learn_rl_td <- function(learning_rate, reward, value_estimate) {
  
  new_value_estimate <- value_estimate + (
    learning_rate * (reward - value_estimate)
  )
  
  return ( new_value_estimate )
}


#### General-purpose ####

softmax <- function(option_values, option_chosen, temperature = NULL) {
  
  if (is.null(temperature) | !is.numeric(temperature)) {
    temperature <- 1
  }
  
  # Standard Gibbs / Boltzmann distribution
  numerator <- exp(option_values[option_chosen] / temperature)
  denominator <- sum(exp(option_values / temperature))
  
  return (numerator / denominator)
}

neg_loglik_logistic <- function(likelihood) {
  if (any(is.nan(likelihood))) {
    warning("Some likelihoods originally NaN, returning NA")
    likelihood <- replace(likelihood, is.nan(likelihood), NA_real_)
  }
  
  if (any(is.infinite(log(likelihood)))) {
    warning("Some likelihoods are too close to 0, returning NA")
    likelihood <- replace(likelihood, is.infinite(log(likelihood)), NA_real_)
  }
  
  if (all(is.na(likelihood))) {
    warning("All likelihoods NA. Likely, the softmax temp is near-zero.")
  } else if (any(likelihood <= 0 | likelihood > 1, na.rm = TRUE)) {
    stop("Some likelihoods out of range (0, 1]. Check for bugs.")
  }
  
  return( -1 * log(likelihood) )
}

calculate_bic <- function(n_params, n_datapoints, neg_loglik) {
  return ( (n_params * log(n_datapoints)) - (2 * -neg_loglik) )
}


#### Tidy optimization ####

run_optim <- function(max_iter_per_run, objective_function,
                      param_guesses, ...) {
  ### Note: I write my objective functions so that `param_names` is a required
  #   named argument. This presents a bit of a headache because I also want to
  #   use the parameter names as an argument for `optim_to_tibble`. So the
  #   unholy compromise is for the user to treat param_names as a named argument
  #   for `run_optim` when in fact it is not formally.
  
  optim_to_tibble <- function(optim_output, param_names) {
    tibble(
      parameter = param_names,
      value = optim_output$par
    ) %>%
      mutate(
        neg_loglik = optim_output$value,
        convergence = case_when(
          optim_output$convergence == 0 ~ "converged",
          optim_output$convergence == 1 ~ "maxit reached",
          optim_output$convergence == 10 ~ "simplex degeneracy",
          TRUE ~ "unknown problem"
        )
      )
  }
  
  param_names_copy <- list(...)$param_names
  
  return (
    optim(
      par = param_guesses,
      fn = objective_function,
      # Usually, ... contains the data argument(s) for the objective function
      ... = ...,
      control = list(maxit = max_iter_per_run)
    ) %>%
      optim_to_tibble(param_names_copy)
  )
}
