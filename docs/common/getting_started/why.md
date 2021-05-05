## Why should you use these pipelines?

A frequent question about these projects is: 

> Why should I care? What value do these pipelines add to my work?

And that's an entirely fair question. This page attempts to provide a good answer. 

### What are they?

A pipeline, in data science terms, is another word for a workflow: a set of common tasks that are applied to raw data to transform, process, or understand it in some way, as data flows through the pipeline from source to destination.

This documentation covers two major pipelines that have been developed for the Moser group at NTNU, the _concept_ can describe just about anything. You probably have a dozen workflows that you use in your every day life without realising it. For example, consider the prototypical start of a work day:

* Arrive at the office
* Fetch coffee
* Sit down at the computer to see how many emails and other messages have piled up over night

  - Read an email
  - Reply if necessary
  - File under a relevant category
  
* Review your to-do list for the day
* Procrastinate and read the news for some time
* Start doing stuff

That, right there, is a workflow. Two if you consider dealing with the email as a separate section. Even just fetching the coffee can be broken down into a separate series of tasks that must happen, in order, to achieve a goal.



The neurocscience pipelines in use at the Moser group are no different in concept: they take a standard series of inputs (assorted data files from various recording instruments), and sift through the data to file it in a standardised, easily accessibly format, and calculate a set of basic screening analyses. All the things that you would naturally do with your data anyway - although, most likely, the output of the pipeline is more reliably consistent than manually sorting your data, because computers are better than humans at this sort of extremely repetitve task.


### Why use them?

You don't have to. The point is, you _should_, and the point of this page is to try and demonstrate to you why it's worth using them. 

Data management is rarely addressed in degree programs and PhD studies - it tends to be left as an exercise to the student. Everyone finds their own adequate way to do it, that works for them. If you've ever had reason to look at how your colleague stores data that is pretty much identical to yours, odds are that it will be _similar_ to how you do it - but different enough that it's annoying to make use of their data, even when they have invited you to do so.

The point of the pipelines is to **standardise** and **automate** that data management across the entire Moser group. Whether data came from a Neuropixels probe, or an Axona tetrode, the resulting data - LFPs, and spike times, subject tracking and so on - is fundamentally the same _kind_ of data. And it's much, _much_ easier to _use_ that data if it's always stored in the same way.

This approach offers numerous benefits, but the two most important benefits are:

* Data is stored in a _structured_ form that allows you to search and query by many, _many_ more attributes than the very limited set availabel in a hierarchical file system.

* **All** data is accessible by the same _method_ and the same _format_. Applying your latest analysis methods to older data just requires you to expand the set of source data you're using, you don't have to spend hours (or days!) updating for technical details about _how the data was stored_ that have changed over time.

Let's look at both of those in more detail.



#### Structured Data

In the course of your studies, you will generate large amounts of research data, probably far more than you are able to categorise just in your head. Eventually, you will find yourself asking questions like "Which data sets met criteria `X` and `Y`? How to find the data sets that you want to analyse?

Just about every scientist will have some kind of written index to their data sets, whether it be stored in Excel sheets, or jotted on the back of post-it notes scattered around the lab. If those indicies store the criteria information you care about, then you can find the data sets you want (fairly) quickly. Your existing indicies probably track very obvious information like, say, date and subject ID. 

But what if you're searching for a criteria that is not stored in the index? In that case, then you face a daunting task - sorting through _all_ of your data to find the ones that match. That's inefficient, and may be impractical depending on how fast you need an answer.

The solution is to _structure_ that metadata, in such a way that it can be easily searched (by either human or computer). You can - and should - already be doing this! Most researchers either maintain handwritten records, or spreadsheets with this information. But it's a tedious job, and humans aren't good at tedious. We get bored, we skip over things, and quality declines. Computers _excel_ at this sort of job - which is why the two pipelines were written. To do this for you.

You can think of this as the difference between storing an entire library of books just alphabetically by author - and by having a proper library catalogue, with new searchable categories like subject, publisher, title, date, length, etc.  


#### Standardised format

The raw data on disk will likely already be in a standardised format - but there is intermediate processing that must be performed. Commonly, this intermediate data will be stored in many subtlely different formats over time, and by different users. That fragmentation leads to difficulty in _using_ the data you have collected.

By planning a common format in advance - and updating _all_ data if and when that format changes - you can access any set of data in a common way, rather than writing (or selecting) a different method for each data set. This commonality also makes it much easier to apply a new analysis method to your older data with relative ease. 


### The data life cycle

Data is not a static, unchanging thing: you will add new data sets to your data, and you may wish to go back to (much) older data for comparison - which, thanks to standardisation, will be more easily accessible.

Beyond that, you will, at some point, **have to publish your data**. If you publish a paper supported by public funds, the data it is based on must also be publicly accessible. 

If you have not planned for this in advance, the publication stage can be a major work package - to go back, and identify each of the datasets involved, export them into an acceptable format, and publish them to an archive.

Using the pipelines offers a simpler method to fulfil your obligations in publishing: a common method to export a set of stored data is provided, and requires only a specification of which sets will be exported. 

Finally, a standardised format supports the Kavli Institute's longer term requirements: it allows us to keep track of and archive data that has not been accessed in longer periods, helping us control the costs of storing your data. 
