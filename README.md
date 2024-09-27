<div align="center">
    <h1>
        Minimalist NVIM IDE
    </h1>
    <p>
        <a href="#dependencies">Dependencies</a>
        ∙
        <a href="#instructions">How to Use</a>
        ∙
        <a href="#customization">Customization</a>
    </p>
    <p align="left">
        This project attempts to create an IDE-like experience for writing and editing code with NVIM.
        The project is heavily inspired by <a href="https://github.com/LunarVim">LunarVim</a> and follows instructions from the excellent step-by-step tutorial <a href="https://www.youtu.be/ctH-a-1eUME?si=mAsw4Qno6kmIIuQy">Neovim IDE from Scratch</a> by <a href="https://www.chrisatmachine.com">chris@machine</a>.
        If you are interested in detailed explanations and guides, you should check him out.
    </p>
    <img src="assets/images/preview.png" alt="My Image" width="600"/>
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
        Once you have all the files inside '~/.config/nvim/', start nvim and run the following command:
    </p>
    <pre><code class="language-bash"><!--
    -->:PackerSync<!--
    --></code></pre>
    <p>
        The command will trigger Packer to install all plugins from their respective repository as specified in 'lua/rezha/plugins.lua'.
        Subsequently, close and reopen nvim.
        Some plugins like Mason and Treesitter will automatically install everything needed for their functionalities.
        You may need to close and reopen nvim several times during these installations.
    </p>
</div>
<div id="customization">
    <h2>
        How to Customize
    </h2>
    <p>
        The project is structured to enable multiple configurations.
        The default configuration is everything inside 'lua/rezha'.
        To create a new configuration, I recommend to copy this directory like in the following:
    </p>
    <pre><code class="language-bash"><!--
    -->cp -r ~/.config/nvim/lua/rezha ~/.config/nvim/lua/newUser<!--
    --></code></pre>
    <p>
        Then change the 'user' specified in '~/.config/nvim/init.lua' from 'rezha' to 'newUser' in this example.
        You can experiment: add, delete, or customize the files inside this new directory.
        Whenever you want to revert the configuration, simply change the 'user' back to 'rezha'.
        That's it!
        You can now create as many configurations as you wish and switch between them by changing the 'user' variable inside 'init.lua'.
    </p>
</div>
