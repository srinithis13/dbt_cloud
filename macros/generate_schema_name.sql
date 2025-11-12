-- macros/generate_schema_name.sql

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    
    {# 1. Check if the current environment target is 'prod' (or your production name) #}
    {%- if target.name == 'prod' -%} 

        {{ default_schema }}

    {%- else -%} 
        
        {# 2. Get the branch name from the environment variable (common in dbt Cloud) #}
        {# Note: The variable name might differ (e.g., CI_COMMIT_REF_SLUG in GitLab) #}
        {%- set branch_name = env_var('DBT_CLOUD_BRANCH', target.name) | lower | replace("-", "_") -%}
        
        {# 3. Concatenate the default schema (e.g., 'DEV') with the branch name #}
        {{ default_schema }}_{{ branch_name }}
        
    {%- endif -%}

{%- endmacro %}