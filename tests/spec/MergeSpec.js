describe("Merger test suite", function() {
  var merger;
  var file1;
  var file2;

  beforeEach(function() {
    merger = new Merger();
  });

  it("should be able to compare 2 strings",function(){

    var str1 = 'Aphex',
        str2 = 'Twin';

    expect(merger.compare(str1,str2)).toEqual(-1);
    expect(merger.compare(str2,str1)).toEqual(1);
  });

  it("should be able to merge 2 single-line files", function() {

    var file1 = ['Alpha'];
    var file2 = ['Bravo'];

    expect(merger.merge(file1,file2)).toEqual(['Alpha','Bravo']);
    expect(merger.merge(file2,file1)).toEqual(['Alpha','Bravo']);
  });

  it("should be able to merge 2 files, when one is bigger than other", function(){

    var file1 = ['Apex','Council','Zeta Johns'];
    var file2 = ['Superior'];

    expect(merger.merge(file1,file2)).toEqual(['Apex','Council','Superior','Zeta Johns']);
    expect(merger.merge(file2,file1)).toEqual(['Apex','Council','Superior','Zeta Johns']);
  });

  it("should be able to ignore empty file",function(){

    var file1 = [];
    var file2 = ['Some Name'];

    expect(merger.merge(file1,file2)).toEqual(['Some Name']);
    expect(merger.merge(file2,file1)).toEqual(['Some Name']);
  })
});

