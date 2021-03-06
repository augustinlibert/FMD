----------------------------------------------------------------------------------------------------
-- Scripting Parameters
----------------------------------------------------------------------------------------------------

local LuaDebug   = require 'Modules.LuaDebugging'
-- LuaDebugging  = true   --> Override the global LuaDebugging variable by uncommenting this line.
-- LuaStatistics = true   --> Override the global LuaStatistics variable by uncommenting this line.


----------------------------------------------------------------------------------------------------
-- Local Constants
----------------------------------------------------------------------------------------------------

local DirectoryPagination = '/directory/'


----------------------------------------------------------------------------------------------------
-- Event Functions
----------------------------------------------------------------------------------------------------

-- Get info and chapter list for current manga.
function GetInfo()
  local v, x = nil
  local u = MaybeFillHost(module.RootURL, url)
  
  --[[Debug]] LuaDebug.WriteLogWithHeader('GetInfo', 'url ->  ' .. u)
  if not http.Get(u) then return net_problem end
  
  x = TXQuery.Create(http.Document)
  mangainfo.Title     = x.XPathString('//meta[@property="og:title"]/@content'):gsub(' | MangaLife', '')
  mangainfo.CoverLink = x.XPathString('//meta[@property="og:image"]/@content')
  mangainfo.Status    = MangaInfoStatusIfPos(x.XPathString('//span[@class="mlabel" and contains(., "Status")]/following-sibling::a[1]'))
  mangainfo.Authors   = x.XPathString('//span[@class="mlabel" and contains(., "Author")]/following-sibling::a[1]')
  mangainfo.Genres    = x.XPathStringAll('//span[@class="mlabel" and contains(., "Genre")]/following-sibling::a')
  mangainfo.Summary   = x.XPathString('//span[@class="mlabel" and contains(., "Description")]/following-sibling::div[1]')
  
  if not http.Get(x.XPathString('//link[@rel="alternate" and @type="application/rss+xml"]/@href')) then return net_problem end
  x = TXQuery.Create(http.Document)
  
  v = x.XPath('//item')
  for i = 1, v.Count do
    mangainfo.ChapterLinks.Add(x.XPathString('link', v.Get(i)))
    mangainfo.ChapterNames.Add(x.XPathString('title', v.Get(i)))
  end
  InvertStrings(mangainfo.ChapterLinks, mangainfo.ChapterNames)
  
  --[[Debug]] LuaDebug.PrintMangaInfo()
  --[[Debug]] LuaDebug.WriteStatistics('Chapters', mangainfo.ChapterLinks.Count .. '  (' .. mangainfo.Title .. ')')
  
  return no_error
end


-- Get links and names from the manga list of the current website.
function GetNameAndLink()
  local x, v = nil
  local u = module.RootURL .. DirectoryPagination
  
  --[[Debug]] LuaDebug.WriteLogWithHeader('GetNameAndLink', 'url ->  ' .. u)
  if not http.Get(u) then return net_problem end
  
  x = TXQuery.Create(http.Document)
  
  json = GetBetween('vm.FullDirectory = ', '}]};', x.XPathString('//script[contains(., "vm.FullDirectory = ")]')) .. '}]}'
  json = json:gsub('\\"', ''):gsub('\\u2019', '\''):gsub('&#', '')
  x.ParseHTML(json)
  print(x.XPathString('json(*).Directory()'))
  v = x.XPath('json(*).Directory()')
  
  for i = 1, v.Count do
	names.Add(x.XPathString('s', v.Get(i)))
    links.Add(module.RootURL .. '/manga/' .. x.XPathString('i', v.Get(i)))
  end
  
  x.XPathHREFAll('//ul[contains(@class, "manga-list")]/li/a', links, names)
  
  --[[Debug]] LuaDebug.PrintMangaDirectoryEntries(u)
  
  return no_error
end


-- Get the page count for the current chapter.
function GetPageNumber()
  local chpnum, partnum, dir, host, name, pages, s, x = nil
  local u = MaybeFillHost(module.RootURL, url)
  
  --[[Debug]] LuaDebug.WriteLogWithHeader('GetPageNumber', 'url ->  ' .. u)
  if not http.Get(u) then return net_problem end
  
  x = TXQuery.Create(http.Document)
  name = GetBetween('vm.IndexName = ', ';', x.XPathString('//script[contains(., "vm.IndexName = ")]')):gsub('"', '')
  host = GetBetween('vm.CurPathName = ', ';', x.XPathString('//script[contains(., "vm.CurPathName = ")]')):gsub('"', '')
  x.ParseHTML(GetBetween('vm.CurChapter = ', ';', x.XPathString('//script[contains(., "vm.CurChapter = ")]')))
  pages = tonumber(x.XPathString('json(*).Page'))
  chpnum, partnum = x.XPathString('json(*).Chapter'):match('%d(%d%d%d%d)(%d)')
  dir = x.XPathString('json(*).Directory')
  
  if partnum ~= '0' then chpnum = chpnum .. '.' .. partnum end
  if dir ~= '' then chpnum = dir .. '/' .. chpnum end
  
  for i = 1, pages do
    task.PageLinks.Add(host .. '/manga/' .. name .. '/' .. chpnum .. '-' .. string.format('%03d', i) .. '.png')
  end
  
  --[[Debug]] LuaDebug.PrintChapterPageLinks()
  --[[Debug]] LuaDebug.WriteStatistics('ChapterPages', task.PageLinks.Count .. '  (' .. u .. ')')
  
  return no_error
end


----------------------------------------------------------------------------------------------------
-- Module Initialization
----------------------------------------------------------------------------------------------------

function Init()
  AddWebsiteModule('MangaLife', 'https://manga4life.com', 'English')
end

function AddWebsiteModule(name, url, category)
  local m = NewModule()
  m.Website               = name
  m.RootURL               = url
  m.Category              = category
  m.OnGetInfo             = 'GetInfo'
  m.OnGetNameAndLink      = 'GetNameAndLink'
  m.OnGetPageNumber       = 'GetPageNumber'
  return m
end