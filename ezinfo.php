<?php
/**
 * @package expAdminUI
 * @class   exp_adminuiInfo
 **/

class exp_adminuiInfo
{
    public static function info()
    {
        return array(
            'Name'      => '<a href="https://github.com/se7enxweb/exp_adminui">Exponential Admin UI : the Netgen Admin UI look for the Exponential administration</a>',
            'Version'   => '1.0.0.3',
            'Author'    => '7x',
            'Copyright' => 'Copyright &copy; 2026 - ' . date( 'Y' ) . ' <a href="https://se7enx.com" target="blank">7x</a>; design ported from Netgen Admin UI, Copyright &copy; Netgen',
            'License'   => "GNU General Public License v2.0 (or any later version)",
            'info_url'  => 'https://github.com/se7enxweb/exp_adminui',
            'Includes the following third-party software' => array(
                'Name'      => 'Netgen Admin UI (se7enxweb/admin-ui-bundle 2.9): stylesheets, fonts, images, scripts and legacy design templates',
                'Version'   => '2.9.15',
                'Copyright' => 'Copyright Netgen (https://netgen.io)',
                'License'   => 'GNU General Public License v2.0 (or any later version)',
            ),
            'Includes the following third-party software (2)' => array(
                'Name'      => 'Font Awesome 4.4, Bootstrap 3.3.5, jQuery UI 1.11.4 resizable, Ace editor, Roboto, Material Icons',
                'Version'   => 'as shipped by Netgen Admin UI 2.9',
                'Copyright' => 'See NOTICE',
                'License'   => 'SIL OFL 1.1 and MIT (Font Awesome), MIT (Bootstrap, jQuery UI), BSD (Ace), Apache 2.0 (Roboto, Material Icons)',
            ),
        );
    }
}
