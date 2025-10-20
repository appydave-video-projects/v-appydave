
# Agents

![Weather](assets/weather.svg)
![Triage](assets/triage.svg)
![Support](assets/support1.svg)

## Weather Agent

This example is a weather agent demonstrating function calling with a single agent. The agent has tools to get the weather of a particular city, and send an email.

![Weather](assets/weather.svg)

## `Agent`

> Instructions: `You are a helpful agent.`

**Handoffs**: [`get_weather`, `send_email`]

### `get_weather`

Get the current weather in a given location. Location MUST be a city.

**Inputs:**

- `location` (str): The location to get the weather for.
- `time` (str): The time to get the weather for, default is "now".

**Outputs:**

- `str`: A JSON string with the location, temperature, and time.

### `send_email`

Send an email to a recipient.

**Inputs:**

- `recipient` (str): The email address of the recipient.
- `subject` (str): The subject of the email.
- `body` (str): The body of the email.

**Outputs:**

- `str`: A message indicating that the email was sent.

## Triage Agent

This example is a Swarm containing a triage agent, which takes in user inputs and chooses whether to respond directly, or triage the request to a sales or refunds agent.

![Triage](assets/triage.svg)

## `Agent`

> Instructions: `Determine which agent is best suited to handle the user's request, and transfer the conversation to that agent.`

**Handoffs**: [`transfer_to_sales`, `transfer_to_refunds`]

### `process_refund`

Refund an item. Make sure you have the item_id of the form item_... Ask for user confirmation before processing the refund.

**Inputs:**

- `item_id` (str): The ID of the item to be refunded.
- `reason` (str, optional): The reason for the refund, default is "NOT SPECIFIED".

**Outputs:**

- `str`: A message indicating the success of the refund.

### `apply_discount`

Apply a discount to the user's cart.

**Outputs:**

- `str`: A message indicating that the discount was applied.

### `transfer_back_to_triage`

Call this function if a user is asking about a topic that is not handled by the current agent.

**Outputs:**

- `Agent`: Returns the triage agent.

### `transfer_to_sales`

Transfers the user to the sales agent.

**Outputs:**

- `Agent`: Returns the sales agent.

### `transfer_to_refunds`

Transfers the user to the refunds agent.

**Outputs:**

- `Agent`: Returns the refunds agent.

## Sales Agent

> Instructions: `Be super enthusiastic about selling bees.`

### `transfer_back_to_triage`

Call this function if a user is asking about a topic that is not handled by the current agent.

**Outputs:**

- `Agent`: Returns the triage agent.

## Refunds Agent

> Instructions: `Help the user with a refund. If the reason is that it was too expensive, offer the user a refund code. If they insist, then process the refund.`

**Handoffs**: [`process_refund`, `apply_discount`, `transfer_back_to_triage`]

### `process_refund`

Refund an item. Make sure you have the item_id of the form item_... Ask for user confirmation before processing the refund.

**Inputs:**

- `item_id` (str): The ID of the item to be refunded.
- `reason` (str, optional): The reason for the refund, default is "NOT SPECIFIED".

**Outputs:**

- `str`: A message indicating the success of the refund.

### `apply_discount`

Apply a discount to the user's cart.

**Outputs:**

- `str`: A message indicating that the discount was applied.

### `transfer_back_to_triage`

Call this function if a user is asking about a topic that is not handled by the current agent.

**Outputs:**

- `Agent`: Returns the triage agent.

# Support Bot

This example is a customer service bot which includes a user interface agent and a help center agent with several tools.

![Support](assets/support1.svg)

## Overview

The support bot consists of two main agents:

## Support Agent

This example is a support agent that handles all interactions with the user. It is called for general questions and when no other agent is suitable for the user query.

## `Agent`

> Instructions: `You are a support agent that handles all interactions with the user. Call this agent for general questions and when no other agent is correct for the user query.`

**Handoffs**: [`query_docs`, `submit_ticket`, `send_email`]

### `query_docs`

Search the knowledge base with the given query.

**Inputs:**

- `query` (str): The search query.

**Outputs:**

- `dict`: A dictionary containing the most relevant article or a message indicating no results found.

### `submit_ticket`

Create a support ticket for the given description.

**Inputs:**

- `description` (str): The description of the issue for the support ticket.

**Outputs:**

- `dict`: A message indicating that the ticket was created.

### `send_email`

Send an email to a recipient.

**Inputs:**

- `email_address` (str): The email address of the recipient.
- `message` (str): The message to be sent.

**Outputs:**

- `dict`: A message indicating that the email was sent.

## Help Center Agent

This example is an OpenAI help center agent that deals with questions about OpenAI products, such as GPT models, DALL-E, Whisper, etc.

## `Agent`

> Instructions: `You are an OpenAI help center agent who deals with questions about OpenAI products, such as GPT models, DALL-E, Whisper, etc.`

**Handoffs**: [`query_docs`, `submit_ticket`, `send_email`]

### `query_docs`

Search the knowledge base with the given query.

**Inputs:**

- `query` (str): The search query.

**Outputs:**

- `dict`: A dictionary containing the most relevant article or a message indicating no results found.

### `submit_ticket`

Create a support ticket for the given description.

**Inputs:**

- `description` (str): The description of the issue for the support ticket.

**Outputs:**

- `dict`: A message indicating that the ticket was created.

### `send_email`

Send an email to a recipient.

**Inputs:**

- `email_address` (str): The email address of the recipient.
- `message` (str): The message to be sent.

**Outputs:**

- `dict`: A message indicating that the email was sent.

### `transfer_to_help_center`

Transfer the user to the help center agent.

**Outputs:**

- `Agent`: Returns the help center agent.