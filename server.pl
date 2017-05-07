:- module(pengine_server,
          [
           server/1,
           stop/1
          ]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(pengines)).
:- use_module(ds_reasoner).
:- use_module(pengine_sandbox:library(pengines)).
:- use_module(pengine_sandbox:library(semweb/rdf_db)).
:- use_module(pengine_sandbox:ds_reasoner).
:- use_module(library(sandbox)).
:- use_module(library(http/http_cors)).
:- http_handler(root(.), http_reply_from_files('./webclient/build/', []), [prefix]).
:- cors_enable.
:- multifile sandbox:safe_primitive/1.


sandbox:safe_primitive(rdf_db:rdf(_,_,_)).
sandbox:safe_primitive(ds_reasoner:reducible(_,_)).
sandbox:safe_primitive(ds_reasoner:solvable(_,_)).
sandbox:safe_primitive(ds_reasoner:stronger_model(_,_)).
sandbox:safe_primitive(ds_reasoner:equivalent_model(_,_)).
sandbox:safe_primitive(ds_reasoner:algorithm_can_solve(_,_)).
sandbox:safe_primitive(ds_reasoner:algorithm_stronger_than(_,_)).

server(Port):-
    http_server(http_dispatch, [port(Port)]).

stop(Port):-
    http_stop_server(Port, []).
