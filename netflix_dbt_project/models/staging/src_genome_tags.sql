-- models/staging/src_genome_tags.sql

SELECT
    TAGID AS tag_id,
    TAG AS tag
FROM {{ source('raw', 'raw_genome_tags') }}
