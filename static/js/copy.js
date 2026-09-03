// A "Copy" button on every code block.

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
    button.textContent = "Copy";
    button.classList.add("copy-button");

    const wrapper = document.createElement("div");
    wrapper.classList.add("code-block-wrapper");

    el.parentNode.insertBefore(wrapper, el);
    wrapper.appendChild(el);
    wrapper.appendChild(button);

    button.addEventListener("click", () => {
      navigator.clipboard.writeText(copyText(el)).then(() => {
        button.textContent = "Copied!";
        setTimeout(() => (button.textContent = "Copy"), 1500);
      }).catch(err => {
        console.error("Copy failed", err);
        button.textContent = "Error";
      });
    });
  });
});
