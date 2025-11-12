-- macros/generate_schema_name.sql

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    
    {# 
      1. Check if the current target name is 'prod' (or your production name)
      2. If it is 'prod', use the default production schema name.
      3. If it's NOT 'prod', append the branch name to the default schema.
    #}
    
    {%- if target.name == 'prod' -%} 

        {{ default_schema }}

    {%- else -%} 
        
        {# Get the branch name from the DBT_CLOUD_BRANCH environment variable #}
        {# or use target.name if you prefer to use the target name for the schema #}
        {%- set branch_name = env_var('DBT_CLOUD_BRANCH', target.name) | lower | replace("-", "_") -%}
        
        {# Concatenate the default schema with the branch name #}
        {{ default_schema }}_{{ branch_name }}
        
    {%- endif -%}

{%- endmacro %}