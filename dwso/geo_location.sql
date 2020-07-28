
With 
cte_1 AS(
    SELECT country_geo_id
            , SUM ( geo_system ) AS system_geo_id
            , SUM ( contenet ) AS contenet_geo_id
            , SUM ( region ) AS region_geo_id
            , SUM ( group_system ) AS group_system_geo_id
      FROM ( SELECT DISTINCT CONNECT_BY_ROOT ( child_geo_id ) AS country_geo_id
                                               , parent_geo_id
                                               , link_type_id
                                               , DECODE ( link_type_id, 1, parent_geo_id ) AS geo_system
                                               , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                                               , DECODE ( link_type_id, 3, parent_geo_id ) AS region
                                               , DECODE ( link_type_id, 4, parent_geo_id ) AS group_system                                              
                                    FROM u_dw_references.t_geo_object_links
                                    CONNECT BY PRIOR parent_geo_id = child_geo_id
                                    START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                                    FROM u_dw_references.cu_countries))
        GROUP BY country_geo_id),
cte_2 AS(
    SELECT  country_geo_id
            , system_geo_id
            , contenet_geo_id
            , region_geo_id
            , group_system_geo_id
            , t2.parent_geo_id AS country_sub_group_geo_id
        FROM cte_1
             LEFT JOIN u_dw_references.t_geo_object_links t2 
                ON ( cte_1.country_geo_id = t2.child_geo_id  AND t2.LINK_TYPE_ID = '6')),
                
geo AS(
     SELECT  country_geo_id
              , system_geo_id
              , contenet_geo_id
              , region_geo_id
              , group_system_geo_id
              , country_sub_group_geo_id
              , t1.parent_geo_id AS country_group_geo_id      
         FROM cte_2              
                LEFT JOIN u_dw_references.t_geo_object_links t1
                ON ( cte_2.country_sub_group_geo_id = t1.child_geo_id  AND t1.LINK_TYPE_ID = '5'))              
SELECT DISTINCT geo.country_geo_id
                         , cnt.country_id
                         , cnt.country_code_a2
                         , cnt.country_code_a3
                         , cnt.region_desc
                         , NVL ( geo.region_geo_id, -99 ) AS region_geo_id
                         , NVL ( reg.src_continent_id, -99 ) AS src_continent_id
                         , NVL ( reg.region_code, 'n.d.' ) AS region_code
                         , NVL ( reg.region_desc, 'n.d.' ) AS region_desc
                         , NVL ( geo.contenet_geo_id, -99 ) AS contenet_geo_id
                         , NVL ( prt.part_id, -99 ) AS part_id
                         , NVL ( prt.part_code, 'n.d.' ) AS part_code
                         , NVL ( prt.part_desc, 'n.d.' ) AS part_desc
                         , NVL ( geo.system_geo_id, -99 ) AS system_geo_id
                         , NVL ( gs.src_geo_system_id, -99 ) AS src_geo_system_id
                         , NVL ( gs.geo_system_code, 'n.d.' ) AS geo_system_code
                         , NVL ( gs.geo_system_desc, 'n.d.' ) AS geo_system_desc
                         , NVL ( geo.group_system_geo_id, -99 ) AS group_system_geo_id
                         , NVL ( cn_gr_s.grp_system_id, -99 ) AS grp_system_id
                         , NVL ( cn_gr_s.grp_system_code, 'n.d.' ) AS grp_system_code
                         , NVL ( cn_gr_s.grp_system_desc, 'n.d.' ) AS grp_system_desc
                         , NVL ( geo.country_group_geo_id, -99 ) AS country_group_geo_id
                         , NVL ( cn_gr.group_id, -99 ) AS group_id
                         , NVL ( cn_gr.group_code, 'n.d.' ) AS group_code
                         , NVL ( cn_gr.group_desc, 'n.d.' ) AS group_desc
                         , NVL ( geo.country_sub_group_geo_id, -99 ) AS country_sub_group_geo_id
                         , NVL ( cnt_sub.sub_group_id, -99 ) AS sub_group_id
                         , NVL ( cnt_sub.sub_group_code, 'n.d.' ) AS sub_group_code
                         , NVL ( cnt_sub.sub_group_desc, 'n.d.' ) AS sub_group_desc      
                    FROM geo
                         LEFT JOIN u_dw_references.cu_countries cnt
                              ON ( geo.country_geo_id = cnt.geo_id )
                           LEFT JOIN u_dw_references.cu_geo_regions reg
                              ON ( geo.region_geo_id = reg.geo_id )
                           LEFT JOIN u_dw_references.cu_geo_parts prt
                              ON ( geo.contenet_geo_id = prt.geo_id )
                           LEFT JOIN u_dw_references.cu_geo_systems gs
                              ON ( geo.system_geo_id = gs.geo_id )
                           LEFT JOIN u_dw_references.cu_cntr_group_systems cn_gr_s
                              ON ( geo.group_system_geo_id = cn_gr_s.geo_id )
                           LEFT JOIN u_dw_references.cu_cntr_groups cn_gr
                              ON ( geo.country_group_geo_id = cn_gr.geo_id )
                           LEFT JOIN u_dw_references.cu_cntr_sub_groups cnt_sub
                              ON ( geo.country_sub_group_geo_id = cnt_sub.geo_id )
                             