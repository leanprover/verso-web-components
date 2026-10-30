// A copy button on every code block.

// What the button says in each state, as its tooltip and for anyone who cannot
// see the icon that `copy-button.css` draws for that state.
const COPY_LABELS = { ready: "Copy", copied: "Copied!", failed: "Copy failed" };

function setCopyState(button, state) {
    const label = COPY_LABELS[state];
    button.dataset.state = state;
    button.title = label;
    button.setAttribute("aria-label", label);
}

// A line of a terminal transcript that the reader typed, rather than one the
// terminal printed back. Only the prompts a shell actually draws count: `#`
// would take a comment for a command, and `>` a quotation.
const PROMPT = /^\s*[❯$%➜]\s+/;

/**
 * What the button puts on the clipboard.
 *
 * A block showing a prompt is a transcript, and its output is there to be read,
 * not pasted: pasting `Hello, world!` back into a shell runs nothing. So when a
 * block has prompts, the commands typed at them are the whole of it. A block
 * with no prompt at all is code, and is copied entire.
 */
function copyText(el) {
    const text = el.innerText;
    const commands = text
        .split("\n")
        .filter((line) => PROMPT.test(line))
        .map((line) => line.replace(PROMPT, ""));

    return (commands.length > 0 ? commands.join("\n") : text).trim();
}

document.addEventListener("DOMContentLoaded", () => {

  const targets = [
    ...document.querySelectorAll("pre"),
    ...document.querySelectorAll("code.hl.lean.block")
  ];

  targets.forEach((el) => {
    // Wrapping is once per block: were this script ever loaded twice, a second
    // pass would hang a second button off the same code.
    if (el.parentElement && el.parentElement.classList.contains("code-block-wrapper")) return;

    // A block the page marked as nothing to take away — a directory listing, a
    // diagram — is left as text.
    if (el.closest(".no-clip")) return;

    const button = document.createElement("button");
    button.classList.add("copy-button");
    setCopyState(button, "ready");

    const wrapper = document.createElement("div");
    wrapper.classList.add("code-block-wrapper");

    el.parentNode.insertBefore(wrapper, el);
    wrapper.appendChild(el);
    wrapper.appendChild(button);

    button.addEventListener("click", () => {
      navigator.clipboard.writeText(copyText(el)).then(() => {
        setCopyState(button, "copied");
        setTimeout(() => setCopyState(button, "ready"), 1500);
      }).catch(err => {
        console.error("Copy failed", err);
        setCopyState(button, "failed");
      });
    });
  });
});
