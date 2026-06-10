import { sparqlEscapeUri } from "mu";

const PUBLIC_GRAPH = "http://mu.semte.ch/graphs/ldes/decide-public";
// NOTE (10/06/2026): Same placeholders as used in sparql-parser configuration
const BAMBERG_GRAPH = "http://mu.semte.ch/graphs/ldes/bamberg";
const FREIBURG_GRAPH = "http://mu.semte.ch/graphs/ldes/freiburg";
const GHENT_GRAPH = "http://mu.semte.ch/graphs/ldes/ghent";

export const GRAPH_FILTER = `
  VALUES ?g {
    ${sparqlEscapeUri(PUBLIC_GRAPH)}
    ${sparqlEscapeUri(BAMBERG_GRAPH)}
    ${sparqlEscapeUri(FREIBURG_GRAPH)}
    ${sparqlEscapeUri(GHENT_GRAPH)}
  }`;

// NOTE (10/06/2026): Not all interesting resources have a triple for this
// predicate already.  It is up to the data producer to add it when updating an
// existing resource, otherwise the changes will not be picked up.
const HEALING_PREDICATE = "http://purl.org/dc/terms/modified";

// NOTE (11/06/2026): These type definitions allow the language-server to
// determine explicit types for functions operating on the `streams` object
// below.  This simplifies writing such functionality and spotting bugs in it.
type ResourceConfig = {
  graphFilter: string;
  healingPredicates: string[];
  filter?: string;
};
type StreamConfig = {
  [resourceType: string]: ResourceConfig;
};
type LdesConfig = {
  [streamName: string]: StreamConfig;
};

export const streams: LdesConfig = {
  public: {
    "http://www.w3.org/ns/dcat#Catalog": {
      graphFilter: GRAPH_FILTER,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://www.w3.org/ns/dcat#Dataset": {
      graphFilter: GRAPH_FILTER,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://www.w3.org/ns/dcat#Distribution": {
      graphFilter: GRAPH_FILTER,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://www.w3.org/ns/dcat#DataService": {
      graphFilter: GRAPH_FILTER,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://www.w3.org/ns/dcat#CatalogRecord": {
      graphFilter: GRAPH_FILTER,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://xmlns.com/foaf/0.1/Agent": {
      graphFilter: GRAPH_FILTER,
      filter: `
        FILTER EXISTS {
          ?catalogOrDataset ?publisherOrContactPoint ?s ;
                            a ?type .
          VALUES ?publisherOrContactPoint {
            <http://purl.org/dc/terms/publisher>
            <http://www.w3.org/ns/dcat#contactPoint>
          }
          VALUES ?type {
            <http://www.w3.org/ns/dcat#Catalog>
            <http://www.w3.org/ns/dcat#Dataset>
          }
        }`,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://www.w3.org/2004/02/skos/core#ConceptScheme": {
      graphFilter: GRAPH_FILTER,
      filter: `
        GRAPH ?g {
          FILTER EXISTS {
            ?catalog <http://www.w3.org/ns/dcat#themeTaxonomy> ?s ;
                     a ?type .
            VALUES ?type {
              <http://www.w3.org/ns/dcat#Catalog>
            }
          }
        }`,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://www.w3.org/2004/02/skos/core#Concept": {
      graphFilter: GRAPH_FILTER,
      filter: `
        GRAPH ?g {
          FILTER EXISTS {
            ?dataset <http://www.w3.org/ns/dcat#theme> ?s ;
                     a ?type .
            VALUES ?type {
              <http://www.w3.org/ns/dcat#Dataset>
            }
          }
        }`,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://purl.org/dc/terms/MediaTypeOrExtent": {
      graphFilter: GRAPH_FILTER,
      filter: `
        GRAPH ?g {
          FILTER EXISTS {
            ?distribution <http://purl.org/dc/terms/format> ?s ;
                          a ?type .
            VALUES ?type {
              <http://www.w3.org/ns/dcat#Distribution>
            }
          }
        }`,
      healingPredicates: [HEALING_PREDICATE],
    },
    "http://mu.semte.ch/vocabulary/cms/Page": {
      graphFilter: GRAPH_FILTER,
      filter: `
        GRAPH ?g {
          FILTER EXISTS {
            ?format <http://mu.semte.ch/vocabulary/cms/page> ?s ;
                    a ?formatType .
            VALUES ?formatType {
              <http://purl.org/dc/terms/MediaTypeOrExtent>
            }
            ?distribution <http://purl.org/dc/terms/format> ?format ;
                          a ?distributionType .
            VALUES ?distributionType {
              <http://www.w3.org/ns/dcat#Distribution>
            }
          }
        }`,
      healingPredicates: [HEALING_PREDICATE],
    },
  },
};

function getElement(stream: string, type: string) {
  return streams[stream]?.[type];
}

export function getGraphFilter(stream: string, type: string) {
  return getElement(stream, type)?.graphFilter;
}

export function getFilter(stream: string, type: string) {
  return getElement(stream, type)?.filter;
}
