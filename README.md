# Repokeeper

## What's all this about?

Repokeeper is a tool for git repositories analysis that highlights common
flaws/bad practices in a workflow.

## Flaws in workflow? What does it mean?

Flaws commonly seen in repository management.

## Why do I need a tool for this?

There are many tools for static code analysis like rubocop, flay, flog,
codeclimate and etc.
Why not analyze repositories?
Unlike code, which can be refactored to fix issues, it's not possible to
refactor repo history (of course, you can rewrite git history, but rewriting
commits merged into master branch is a bad idea).
By using Repokeeper, you can explore what was wrong in project's history, and
then adjust your process accordingly.


Problems with project management usually leave traces in repository history and
structure.
For instance, a rush in delivery of features to production can lead to debugging
and fixing in production, which in turn, leads to many `fix`-like commits.

## Story behind this project

Once upon a time... while reviewing a pull request, the author found two commits
saying:

    Implementing uploader
    Implementing uploader

His immediate thoughts were: "WTF??? What is it? Did the first attempt fail to
work?"
But then, he decided to write a tool to analyze other repos to see if this was a
unique case, or if he had stumbled upon a more common problem.

## What can this tool tell me about my repo?

Tool detects following problems:

* **Short commit message.**
The most important thing one can do using any VCS is to write meaningful commit
message, because it will help others to better understand your changes.
If you find commit messages like: `fix` or `!!!`, that means someone doesn't do
a good job in revealing the intention behind these commits.

* **Duplicate commit message.**
A sequence of two or more sequential commits with the same message might
indicate that someone didn't find time to squash those commits or that someone
pushed a fix to master (or even deployed it to production) and it didn't work.

* **Merge commit.**
This is a commit with 2 parents. It's hard to follow project history if it
includes tons of merges.
This analysis might be useful in case you follow rebase and fast-forward only
merges workflow. Read more about rebase
[here](http://randyfay.com/content/rebase-workflow-git)
or [here](http://robots.thoughtbot.com/rebase-like-a-boss).

* **Issues with branches**.
Branches analyzers are experimental, and there are will be changes in future.
At this moment, the tool reports a warning if you have too many local or remote
branches.
Too many branches can indicate that you aren’t maintaining your repository well
(i.e., you aren’t deleting local and remote feature branches after merging it).

## OK, I want to try it

Install it from ruby gems

    $ gem install repokeeper

After that

* Goto some repo's directory
* Run `repokeeper`
* Have fun

Also you can pass a path to repository, instead switching to the directory with
the repository: `repokeeper super_cool_project`

You can override default analyzers settings providing a config file with `-c`
option, e.g. `repokeeper -c .repokeeper.yml`

See `config/default.yml` for configuration file example.

**NOTE:** `repokeeper` without `-c` argument doesn't load `.repokeeper.yml`
from current directory even if it exists.

## I have a big project, and use non-fastforward merges all the time

If you are annoyed by tons of merge commits warnings, you can disable it,
by `enabled: false` option in config file.

## More fun with custom formatters

You can provide custom formatter class to change output the way you want,
or calculate statistics.

To do this you should require ruby file with formatter class using `--require`
option and provide formatter class name using `--formatter` option.

### Complex example on how to use custom formatters

Let's create a list of most common short commit messages in a repository.

```{ruby}
# messages_score_formatter.rb
class MessagesScoreFormatter
  def initialize(out_stream = $stdout)
    @out_stream = out_stream
  end

  def started
    @counts = Hash.new(0)
  end

  def commits_analyzer_results(analyzer_name, offenses)
    Array(offenses).each do |offense|
      messsage = offense.commit.message.strip.downcase
      @counts[messsage] += 1
    end
  end

  def branches_analyzer_results(analyzer_name, offenses)
  end

  def finished
    @counts.sort_by{ |_, v| -v }.each do |k, v|
      @out_stream.puts "#{k}: #{v}"
    end
  end
end
```

We are interested to use only short commit messages analyzer, so other analyzers
can be disabled in configuration file:

```{yaml}
# .repokeeper.yml
local_branches_count:
  enabled: false

remote_branches_count:
  enabled: false

merge_commits:
  enabled: false

short_commit_message:
  message_min_length: 10

similar_commits:
  enabled: false
```

And everything is ready to run:

    repokeeper --require ./messages_score_formatter.rb \
               --formatter MessagesScoreFormatter \
               -c .repokeeper.yml super_cool_project

## Contributing

You know what to do.
But don't forget to run `repokeeper` against your new commits ;)


## Contact

Anatoliy Plastinin

- http://github.com/antlypls
- http://twitter.com/antlypls
- hello@antlypls.com

## License

See `LICENSE`
