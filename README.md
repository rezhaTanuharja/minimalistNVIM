<div align="center">
    <h1>
        Minimalist Neovim
    </h1>
    <p>
        <a href="#dependencies">Dependencies</a>
        ∙
        <a href="#instructions">How to Use</a>
        ∙
        <a href="#looks">How It Looks</a>
    </p>
    <p align="left">
        This project attempts to create an IDE-like experience for writing and editing code with Neovim.
        The configuration is heavily inspired by <a href="https://github.com/LunarVim">LunarVim</a> and followed instructions from the excellent step-by-step tutorial <a href="https://www.youtu.be/ctH-a-1eUME?si=mAsw4Qno6kmIIuQy">Neovim IDE from Scratch</a> by <a href="https://www.chrisatmachine.com">chris@machine</a>.
        If you are interested in detailed explanations and guides, you should check him out.
    </p>
    <img src="assets/images/preview.png" alt="Preview" width="600"/>
    <br>
    <br>
    <p align="left">
    As the title of the project suggests, the configuration is pretty minimalistic: it does not use any colorscheme, at least not in a traditional sense, and it keeps the number of plugins as low as possible.
    The main reasons for this philosopy are:
    </p>
    <ul align="left">
        <li>I like to read novels with the dark mode and when I do, I can read continuously for hours without straining my eyes. Thus, I chose the colors to emulate the same feeling.</li>
        <li>Maintaining a large configuration structure requires significant time commitment and efforts. The less config / plugins I have, the easier it is for me to maintain it.</li>
    </ul>
    <p align="left">
    That being said, if you are a Neovim user, I hope you see something interesting to adopt to your own config. If you are still considering Neovim, I hope you become a part of our community soon!
    </p>
</div>

<div id="dependencies">
    <h2>
        Dependencies
    </h2>
    <p>
        You need <a href="https://neovim.io">neovim</a> v.0.10.x or newer and <a href="https://www.lua.org">Lua</a> on your machine to use the project.
        If you are using MacOS, the default terminal may not display the correct colors.
        In this case, I highly recommend to use <a href="https://iterm2.com">iTerm2</a> instead.
    </p>
</div>

<div id="instructions">
    <h2>
        How to Use
    </h2>
    <p>
        During startup, nvim looks for a configuration file inside the nvim directory, which is typically '~/.config/nvim/'.
        To use the project, you can simply clone the repository using <a href="https://git-scm.com">Git</a>:
    </p>
    <pre><code class="language-bash"><!--
    -->git clone https://github.com/rezhaTanuharja/minimalistNVIM.git ~/.config/nvim<!--
    --></code></pre>
    <p>
        Once you have all the files inside '~/.config/nvim/', simply start Neovim and <a href="https://github.com/folke/lazy.nvim.git">Lazy</a> will automatically install all of the plugins in this project.
    </p>
</div>
<div id="looks">
    <h2>
        How It Looks
    </h2>
    <p>
    The colors are mostly (not all!) grayscale.
    A typical Python code looks like the following.
    The colors are chosen such that I can parse Python codes easily and let me focus on the code instead of the comments.
    </p>
    <div>
        <img src="assets/images/code.png" alt="Preview" width="600"/>
    </div>
    <br>
    <p>
    I do not use any icon other than what is available on a standard keyboard.
    This is because I do not really like to use icons and also because custom icons require more efforts to integrate into my colors selection.
    The plugin <a href="https://github.com/nvim-tree/nvim-tree.lua.git">nvim-tree</a> looks like this:
    </p>
    <div>
        <img src="assets/images/nvimtree.png" alt="Preview" width="220"/>
    </div>
    <p>
    The files are indicated with the letter x, directories are indicated with the square brackets where the orientations of and characters inside the brackets indicate if the directories are open, closed, empty, and so on.
    Modified files and directories are simply marked by asterisks.
    </p>
    <p>
    In some parts, I do some color play.
    For example, my <a href="https://github.com/nvim-lualine/lualine.nvim.git">lualine</a> looks like the following in normal and command mode, respectively:
    </p>
    <div>
        <img src="assets/images/lualine_normal.png" alt="Preview" width="700"/>
        <img src="assets/images/lualine_command.png" alt="Preview" width="700"/>
    </div>
    <p>
    When I code, I stare at a (mostly) black screen.
    When I enter command mode, the midsection of the lualine change into a bright white color.
    This has a "flash" effect and my attention instinctively snaps to the bottom of the screen, where it needs to, because I am in the command mode.
    </p>
    <p>
    I still keep colors for important parts such as diagnostics, TODO, BUGS, etc..
    As an example, here is how a FIXME and a TODO from <a href="https://github.com/folke/todo-comments.nvim.git">todo-comments</a> look like:
    </p>
    <div>
        <img src="assets/images/fixme.png" alt="Preview" width="600"/>
    </div>
    <p>
    This is another benefit of using a (mostly) grayscale colors: important colors such as red (error) and yellor (warning) pops out and attract our attention immediately.
    </p>
</div>
