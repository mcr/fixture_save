# Fixture Save

A small set of libraries to permit production data to be saved to fixtures
such that it can be brought in a fixtures in test cases.

A future version will provide for anonymization of the data.

To use this,
   include FixtureSave

into your models (or application_record).

It assumes that all models have a way to generate a name useable in a fixture.
If not:
   def simplename
       "something#{id}"
   end

in the model.

Unless overridden, savefixturefw(fw) will write the current model out to the
FixtureWriter "fw".  Typically a model will want to override this to write out
relevant associations.  Loops are managed because FixtureWriter provides
a mechanism so that save_self_tofixture(fw) can keep track of which objects
have been written and avoides writing them twice.

Typically an overridden version will look like:

    class Blog
      belongs_to :author
      has_many :posts
      ...
      def savefixturefw(fw)
        return if save_self_tofixture(fw)

        author.savefixturefw(fw) if author
        # now for related items: has_many :posts
        posts.each { |p| p.savefixturefw(fw) }
      end
    end

savefixturefw should write itself out first so that the current object is written
and that fact is recorded.  save_self_to_fixture will return true if the object
was already written, which avoids even attempting to save the related objects.

In production, one might use it as follows:

   rails console production
   > fw = FixtureSave::FixtureWriter.new("/tmp/directory")
   > blog1 = Blog.find(2345)
   > blog1.savefixturefw(fw)
   > fw.closefiles

The FixtureWriter will make up file name for each model that is saved using
the models' name, and put the files into /tmp/directory, which should already exist.
If files already exist, they will be appended to.

The files will be kept open and fw can be used to dump many objects (using a
write-once cache).  If one wants to example the results without exiting the console,
then closefiles can be used to close all the open files, emptying the cache.

If one continues at after closefiles, files will be appended to.  The write-once
cache is kept however.

# HISTORY

This code was first written around 2008 at Simtone CDU, but was only turned into
a GEM in 2017.



