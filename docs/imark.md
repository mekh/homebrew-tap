# Imark

[Imark](https://github.com/migsilva89/imark) is a Markdown reader for macOS by
Miguel Silva, with review notes kept inside the file. The `imark` cask in this
tap installs a build of it from [mekh/imark](https://github.com/mekh/imark): the
upstream app with the fixes still waiting to be merged there, plus a few things
that stay in this build only. Ask, the assistant described below, is one of
them. The notes of each [release](https://github.com/mekh/homebrew-tap/releases?q=imark)
list what the build adds.

- [Install, update, remove](#install-update-remove)
- [Ask: an assistant for what you read](#ask-an-assistant-for-what-you-read)
  - [Turn it on](#turn-it-on)
  - [Which assistant](#which-assistant)
  - [The Assistants window](#the-assistants-window)
  - [Claude Code](#claude-code)
  - [Codex](#codex)
  - [OpenAI](#openai)
  - [OpenRouter](#openrouter)
  - [Anthropic API](#anthropic-api)
  - [Other OpenAI-compatible APIs](#other-openai-compatible-apis)
  - [Local models: LM Studio, Ollama and others](#local-models-lm-studio-ollama-and-others)
  - [Tools and context](#tools-and-context)
  - [Asking](#asking)
  - [What leaves your Mac, and what is kept](#what-leaves-your-mac-and-what-is-kept)
  - [When something goes wrong](#when-something-goes-wrong)

## Install, update, remove

```sh
brew install --cask mekh/tap/imark     # install
brew upgrade --cask imark              # update
brew uninstall --cask imark            # remove the app
brew uninstall --zap --cask imark      # also remove its settings
```

The app is Developer ID–signed and notarized and needs macOS Sonoma or later.
It updates itself from this tap: it checks for new versions on its own, and
Imark ▸ Check for Updates… asks at once. The cask also links the `imark`
command into Homebrew's `bin`.

This build has the same bundle identifier as the upstream one, so it reads the
same settings. Keep only one of the two installed.

## Ask: an assistant for what you read

Select a passage, press ⌘J and ask about it. The answer comes in a card beside
the passage and cites the lines it rests on. The assistant can be Claude Code or
Codex, signed in with your own account, an API such as OpenAI, OpenRouter or
Anthropic's, or a model running on your Mac in LM Studio or Ollama. Whichever it
is, it can read the document it was asked about and nothing else.

### Turn it on

Ask is off until you turn it on, because asking sends the document to whoever
runs the model.

1. Open **Imark ▸ Settings…** (⌘,). In the **Ask** group, tick
   **Show Ask in the selection row and toolbar**.
2. Click **Assistants…**, set up at least one assistant as described below, and
   click **Save**.
3. Choose it in **Ask with**. That is the assistant a new chat goes to.

The same group has two more settings:

- **Keep chats**: *Until I delete them* (the default; chats are saved on disk),
  *Until Imark quits*, or *While the chat is open*. Only the first writes
  anything to disk.
- **Usage**: shows tokens and cost under every answer.

**Delete All Chats…** removes the chats about every document. Notes kept from
answers stay in the documents.

### Which assistant

| Assistant | Sign-in | Where the model runs | Cost under answers | Answer appears |
| --- | --- | --- | --- | --- |
| [Claude Code](#claude-code) | Claude Code's own: a Claude plan or an Anthropic Console account | Anthropic | Yes, as Claude Code counts it | Word by word |
| [Codex](#codex) | Codex's own: a ChatGPT plan or an OpenAI API key | OpenAI | Tokens only | All at once |
| [OpenAI](#openai) | API key | OpenAI | Tokens only | Word by word |
| [OpenRouter](#openrouter) | API key | The provider of the model you pick | Yes, as OpenRouter reports it | Word by word |
| [Anthropic API](#anthropic-api) | API key | Anthropic | Tokens only | Word by word |
| [Other OpenAI-compatible](#other-openai-compatible-apis) | A key, if the server wants one | Wherever the server is | When the server reports it | Word by word |
| [LM Studio, Ollama and others](#local-models-lm-studio-ollama-and-others) | None | Your Mac | Nothing to pay | Word by word |

If you already pay for Claude or ChatGPT, Claude Code or Codex uses that plan
and needs no API key. Neither a Claude nor a ChatGPT plan comes with an API key:
the API entries are billed by their providers separately.

### The Assistants window

**Settings ▸ Ask ▸ Assistants…** lists the assistants on the left and shows the
one selected on the right.

- **Claude Code** and **Codex** are always listed. They read *Not set up* until
  Imark has an executable to run.
- **+** adds an API: *OpenAI*, *OpenRouter*, *LM Studio*, *Ollama*,
  *Other OpenAI-compatible API* or *Anthropic API*. The first four and the last
  come with their address filled in.
- **−** removes the selected API, with its key and its list of models.
- **Use for Ask** decides whether an assistant is offered at all.

Nothing is written until you click **Save** (or press Return). **Cancel** (or
Escape) asks before throwing changes away.

An API has these fields:

| Field | What goes in it |
| --- | --- |
| Name | What the chip under a question says. |
| Address | The server's base URL, the part before `/chat/completions`. Imark adds `https://` (`http://` for this Mac) and takes off a pasted `/chat/completions` or `/models`. |
| API key | Pasted once, kept in the Keychain, never shown again. Leave it empty to keep the stored one, or when the server needs none. |
| Model | Click **Get Models** to fetch the server's list, then click the field to pick from it or type to narrow it. The line under the field says the model's context, whether it takes tools, and its price, where the server says them. Or type the model's name. |
| Tools | *Automatic* (the default), *Always* or *Never*. See [Tools and context](#tools-and-context). |
| Context | The model's context window, in tokens. Filled in when you pick a model from a list that says it. |

Imark asks a server for its models only when you click **Get Models**, and keeps
the list until you click it again.

### Claude Code

1. Install Claude Code and sign in once:

   ```sh
   brew install --cask claude-code
   claude
   ```

   Sign in when `claude` asks, then leave it with `/exit`. Anthropic's own
   installer and npm work as well.
2. In **Assistants…**, select **Claude Code**. **Executable** is filled in with the
   `claude` Imark found, and the line under it says what `claude --version`
   answers. If it is empty or wrong, click **Choose…** and pick the executable
   (`which claude` in Terminal shows where it is).
3. **Model**: leave it empty for Claude Code's default, or pick `opus`, `sonnet`
   or `haiku`, or type a full model name.
4. **Spending cap** (optional): the most one question may cost, in US dollars.
   Claude Code stops an answer that would cost more. On a subscription the sum
   is Claude Code's estimate, not a bill.
5. Tick **Use for Ask** and click **Save**.

How Imark runs it: `claude -p` with its own tools turned off and only Imark's
document tools, served to it over MCP by Imark itself. Ask's instructions replace
Claude Code's system prompt, which is written for working in a code base. Your
Claude Code settings, hooks and slash commands are not loaded, so a hook that
plays a sound or runs a script does not fire for every question. It runs in
`~/Library/Caches/Imark/Ask`, so no project's `CLAUDE.md` comes along and its
sessions stay out of your projects. A follow-up question resumes the same
session.

### Codex

1. Get Codex, in any of these ways:
   - **ChatGPT for Mac** has Codex inside. Nothing more to install: you choose
     ChatGPT.app in step 2.
   - `brew install --cask codex`
   - `npm install -g @openai/codex`
2. Sign in once, with the Codex you will use:

   ```sh
   codex login
   ```

   For the one inside ChatGPT.app:

   ```sh
   /Applications/ChatGPT.app/Contents/Resources/codex-cli/bin/codex login
   ```

3. In **Assistants…**, select **Codex** and click **Choose…**. Pick the
   executable, or pick an app: Imark looks for `codex` inside the app you chose,
   and only there. The line under the field says what `--version` answers.
   Imark takes the path you set rather than a guess, since a Mac often has
   more than one Codex, an app's and an npm one, of different versions.
4. **Model**: leave it empty for what your account is given, or pick one.
5. Tick **Use for Ask** and click **Save**.

How Imark runs it: `codex exec` in a read-only sandbox, with its shell, web
search, images, apps, plugins and sub-agents turned off, and Imark's document
tools as a required MCP server. Your `~/.codex/config.toml` is not loaded. Two
things cannot be turned off: Codex's patch tool, which the read-only sandbox
refuses anyway, and your global `~/.codex/AGENTS.md`, which Codex always reads.
If that file has rules for writing code, they reach Ask's answers too.

Codex sends each message whole, so an answer appears at once when it is done,
not word by word. It reports tokens but not cost.

### OpenAI

1. Create a key at [platform.openai.com/api-keys](https://platform.openai.com/api-keys).
2. In **Assistants…**, click **+ ▸ OpenAI**. The address is
   `https://api.openai.com/v1`.
3. Paste the key into **API key**.
4. Click **Get Models** and pick a model.
5. Click **Save**.

OpenAI's list does not say how large each model's context is. Fill in
**Context** only if you set **Tools** to *Never*: it decides whether the whole
document fits.

### OpenRouter

[OpenRouter](https://openrouter.ai) reaches models of many providers with one
key.

1. Create a key at [openrouter.ai/settings/keys](https://openrouter.ai/settings/keys).
2. In **Assistants…**, click **+ ▸ OpenRouter**. The address is
   `https://openrouter.ai/api/v1`.
3. Paste the key, click **Get Models** and pick a model. Its name carries the
   provider, as in `anthropic/claude-sonnet-5`; names ending in `:free` cost
   nothing. The line under the field says the model's context, whether it takes
   tools, and its price per million tokens, and picking it fills in **Context**.
4. Click **Save**.

OpenRouter reports the price of every answer, and Imark shows it. Its activity
page lists the requests under the name Imark. A model that takes tools reads
only the parts of a long document it needs, so it costs less than one that has
to be given the document.

### Anthropic API

1. Create a key in the [Anthropic Console](https://console.anthropic.com/settings/keys).
   To use a Claude Pro or Max plan instead, set up [Claude Code](#claude-code).
2. In **Assistants…**, click **+ ▸ Anthropic API**. The address is
   `https://api.anthropic.com`.
3. Paste the key, click **Get Models** and pick a model, such as
   `claude-sonnet-5`.
4. Click **Save**.

An answer is at most 4,096 tokens long. The API reports tokens but not cost.

### Other OpenAI-compatible APIs

Most providers and servers speak OpenAI's protocol. Click
**+ ▸ Other OpenAI-compatible API**, type the address, paste a key if the server
wants one, and pick or type the model. The entry is named after its host until
you give it a name. Some addresses:

| Service | Address |
| --- | --- |
| Groq | `https://api.groq.com/openai/v1` |
| Mistral | `https://api.mistral.ai/v1` |
| DeepSeek | `https://api.deepseek.com/v1` |
| Google Gemini | `https://generativelanguage.googleapis.com/v1beta/openai` |
| Together | `https://api.together.xyz/v1` |

A server on another machine of your network works the same way, by its address.

### Local models: LM Studio, Ollama and others

With a model on your Mac, nothing leaves it and there is nothing to pay: the
line under an answer says *local*, and its details give the cost as *Nothing*.
An address on `localhost`, `127.0.0.1`, `::1` or a `.local` name counts as this
Mac, and needs no key.

What makes a local model good for Ask:

- **It takes tools** (tool or function calling), so it can search the document
  and read what it needs. Qwen 3, Llama 3.1 and later, Mistral Small and gpt-oss
  do. A model that does not is given the document itself, which works for short
  documents.
- **A context of 16K tokens or more.** Both LM Studio and Ollama start a model
  with a short context unless told otherwise, and a long document or a few rounds
  of searching overflows it.

#### LM Studio

1. Download a model in [LM Studio](https://lmstudio.ai).
2. Start its server: the **Developer** tab, **Status** set to *Running*, or
   `lms server start` in Terminal. The port is 1234.
3. Load the model, with **Context Length** set to 16384 or more. With
   just-in-time loading turned on, LM Studio loads it at the first question.
4. In **Assistants…**, click **+ ▸ LM Studio**. The address is
   `http://localhost:1234/v1`. Leave **API key** empty.
5. Click **Get Models**, pick the model, and write the context length you loaded
   it with into **Context**.
6. Click **Save**.

#### Ollama

1. Install [Ollama](https://ollama.com), the app or `brew install ollama`
   (then `brew services start ollama`).
2. Get a model:

   ```sh
   ollama pull qwen3:8b
   ```

3. Give it room: **Context length** in the Ollama app's settings, or start the
   server with a larger default:

   ```sh
   OLLAMA_CONTEXT_LENGTH=16384 ollama serve
   ```

4. In **Assistants…**, click **+ ▸ Ollama**. The address is
   `http://localhost:11434/v1`. Leave **API key** empty.
5. Click **Get Models**, pick the model, write the same context length into
   **Context**, and click **Save**.

#### Other local servers

llama.cpp's `llama-server` (`http://localhost:8080/v1`), vLLM
(`http://localhost:8000/v1`), Jan (`http://localhost:1337/v1`) and the like go
in through **+ ▸ Other OpenAI-compatible API**, with the address of the server
as it runs on your Mac.

### Tools and context

An assistant can be given three tools, all of them read-only and all limited to
the document it was asked about: the list of **headings**, **reading** lines,
and **searching**. Claude Code and Codex always get them. For an API, the
**Tools** field decides:

- *Automatic*: the model is offered the tools. If the server answers that the
  model takes none, Imark asks again without them and remembers that, as the
  note under the field then says. Picking another model, or another choice
  here, makes it try again.
- *Always*: the tools are always offered.
- *Never*: the model is always given the document itself.

With tools, a question goes with the passage and its paragraph, and the model
looks up the rest when it needs to. That keeps long documents cheap. Without
tools, the whole document goes with every question when it fits in half the
**Context** (at about four characters a token, 32K tokens when **Context** is
empty); otherwise the section around the passage and the list of headings go.

The line at the bottom of a chat says which it is: *Can search the document*,
*Given the whole document* or *Given this section*.

### Asking

- **Ask about a passage.** Select it and press ⌘J, or click **Ask** in the row
  over the selection. A card opens beside the passage, with quick questions to
  pick from (*Explain*, *In simpler words*, *Summarise*, *Why it matters here*;
  *Define* and *An example* for a single word) or a field to type in. Return
  sends; Shift-Return starts a new line. The answer comes in the language you
  asked in.
- **Ask about the whole document.** Press ⇧⌘J or click **Ask** in the toolbar
  for the side panel, then **+**. ⌘J with nothing selected opens the panel too.
- **Read the answer.** Line numbers such as `[L42]` are chips that take the page
  to those lines. Above the answer, the chat shows what the assistant looked up
  on the way. Under it are **Copy**, **Keep as a note**, which writes the answer
  into the document as a note on the passage, signed by the assistant, and
  **Ask again**. While an answer is coming, **Stop** ends it.
- **Keep the chat going.** Ask a follow-up in the same card, or move the card to
  the side panel. The panel lists every chat about the document under
  **Chats**, can be dragged wider, and its quote at the top of a chat takes the
  page back to the passage (⌘[ returns). Chats are marked in the margin beside
  the notes; a click on the mark opens the chat again.
- **Change the assistant.** The chip under the question lists the assistants that
  are turned on, and the models to pick for Claude Code and Codex. The one picked
  answers the next question.
- **See what it cost.** The line under an answer gives tokens and cost; click it
  for input, output, time, speed and who reported the cost. The panel's header
  gives the total for the chat.

Both commands are in the **View** menu as well: **Ask About Selection** (⌘J) and
**Ask Panel** (⇧⌘J). Ask is not available while the document is being edited.

### What leaves your Mac, and what is kept

- **Sent** to whoever runs the model: your question, the passage and its
  paragraph, and whatever part of the document the assistant reads, or the
  document itself for a model without tools. With a local model nothing leaves
  the Mac.
- **Never read:** other files, other documents, the web. The assistant is told
  that the document is data and not instructions to follow. A document can still
  try to steer an answer, so treat answers about documents from elsewhere with
  the care you would give the documents themselves.
- **Never loaded:** nothing in an answer loads from the internet. An image in an
  answer shows as a link.
- **API keys** are in the login Keychain, as *Imark Ask* items, and nowhere else.
  macOS may ask once whether Imark may read them; click **Always Allow**, and
  updates keep that answer.
- **Chats**, when kept until you delete them, are in
  `~/Library/Application Support/Imark/Chats`, one file per chat, never in the
  document. Lists of models are in `~/Library/Caches/Imark/Models`, and Claude
  Code and Codex run in `~/Library/Caches/Imark/Ask`. The assistants you set up
  are in Imark's settings, without their keys.

To remove it all: **Delete All Chats…**, remove each API in **Assistants…** (its
key goes with it), and delete the two `Imark` folders above.

### When something goes wrong

The error under a question says what to check, and those about the setup come
with a **Settings…** button.

| What you see | What to do |
| --- | --- |
| No Ask in the selection row or the toolbar | Turn it on in **Settings ▸ Ask**. It is not offered while editing. |
| *No assistant is set up* | Tick **Use for Ask** for one in **Assistants…** and save. |
| *Claude Code is not set up* (or Codex) | Set **Executable** in **Assistants…**. |
| Claude Code or Codex says it is not signed in | Run `claude` or `codex login` in Terminal, with the same executable Imark runs. |
| *Imark's document tools did not reach Claude Code* | Update Claude Code (`brew upgrade --cask claude-code`, or `claude update`). |
| *Pick a model for …* | An API needs a model: **Get Models**, or type one. |
| *… refused the key* | Paste the key again in **Assistants…** and save. |
| *… has no model called …* | Pick the model from **Get Models** instead of typing it. |
| *… could not be reached* | For LM Studio or Ollama, start its server and check the port in the address. |
| macOS asks for your password at every question | Click **Always Allow**, not Allow. |
| The answer invents lines, or looks nothing up | Pick a model that takes tools, or set **Tools** to *Never* so it gets the document. With a local model, raise its context. |
| Codex answers like a coding assistant | Your `~/.codex/AGENTS.md` reaches it; Codex offers no way to leave it out. |
