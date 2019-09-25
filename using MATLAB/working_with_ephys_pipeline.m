clc, close all, clear all

%% =================== Working with the existing ephys pipeline =============================
% As different components of the ephys pipeline have been introduced
% In this workshop, we will demonstrate how to connect to and work with
% different schemas in the ephys pipeline

%% =================== Setup the database connection ====================
% This is equivalent to the steps of setting up database name, username and
% password credentials with dj.config['database.host'] in python

setenv DJ_HOST datajoint.it.ntnu.no
setenv DJ_USER thinh
% setenv DJ_PASS 'haha not my real password'

dj.conn();

%% =================== Import the schemas ===============================

import animal.*
import reference.*
import acquisition.*
import tracking.*
import behavior.*
import ephys.*
import analysis.*
import analysis_params.*

%% ================== Query & fetch syntax ================================

animal.Animal & 'animal_dob > "2018-01-01"'

acquisition.Session & 'session_time = "2019-07-04 20:35:12"'

this_sess = (acquisition.Session & 'session_time > "2019-07-04 20:35:12"')
this_sess.fetch()

% however, this wont' work
% (acquisition.Session & 'session_time > "2019-07-04 20:35:12"').fetch()

% basically, build the query into a variable first, then fetch from the query

%% =================== fetch in MATLAB ===================

ratemap_q = analysis.RateMap & 'session_time = "2017-10-02 15:54:25"'

% 1. fetch() will always return a structure array 
ratemap_q.fetch()
% 2. fetch() will always return the structure array of primary attributes
ratemap_q.fetch()
% 3. if we wish to get all attributes, do .fetch('*')
ratemap_q.fetch('*')
% 4. if we just want to get subset of attributes
ratemap_q.fetch('ratemap', 'selectivity')

% the primary attributes always get shipped with fetch()

ratemaps = ratemap_q.fetch('ratemap');

figure;
for r = 1:numel(ratemaps)
    ratemap = ratemaps(r).ratemap;
    subplot(3, 2, r)
    imagesc(ratemap)
end


% ---- fetchn (only in MATLAB) ----
% with fetchn, we can specify with attribute(s) to get back
% without having to get the struture array with primary attributes

ratemap_q.fetchn('selectivity')

ratemap_q.fetchn('ratemap')

[selectivities, ratemaps] = ratemap_q.fetchn('selectivity', 'ratemap')


figure;
for r = 1:numel(ratemaps)
    ratemap = ratemaps{r};
    subplot(3, 2, r)
    imagesc(ratemap)
end

