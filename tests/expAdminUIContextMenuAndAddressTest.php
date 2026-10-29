<?php
/**
 * Three fixes of the Admin UI design, checked in its files without a kernel or a database:
 *
 *   php vendor/bin/phpunit --no-configuration extension/exp_adminui/tests/expAdminUIContextMenuAndAddressTest.php
 *
 *  AU-01 - The map location edit template prints the address only decoded and washed
 *          (|html_entity_decode|wash): ezgmaplocation up to 6.0.6 stores it with entities, later as typed
 *  AU-02 - The context menu script builds the menus declared in data-menu-* attributes and links and redirects
 *          only to addresses of the site; the behavior itself is tested with the core's menu harness
 *          (tests/tests/design/js/csp_popupmenu.js of Exponential 6)
 *  AU-03 - The dropdowns of the Admin UI keep a click inside them, except on an entry that opens a declared popup
 *          menu (data-menu-open): the menu script listens on the document, so Import/Export opened nothing
 *
 * @copyright Copyright (C) 1998 - 2026 Exponential Foundation and 7x. All rights reserved.
 * @license GNU General Public License v2.0 (or any later version)
 */

use PHPUnit\Framework\TestCase;

class expAdminUIContextMenuAndAddressTest extends TestCase
{
    /** AU-01 */
    public function testAddressIsDecodedAndWashed()
    {
        $source = (string)file_get_contents( dirname( __DIR__ ) . '/design/adminui/templates/content/datatype/edit/ezgmaplocation.tpl' );
        preg_match_all( '/\{\$attribute\.content\.address[^}]*\}/', $source, $matches );
        $this->assertCount( 2, $matches[0] );
        foreach ( $matches[0] as $print )
        {
            $this->assertSame( '{$attribute.content.address|html_entity_decode|wash}', $print );
        }
    }

    /** AU-02 */
    public function testContextMenuScriptIsTheDeclaredOne()
    {
        $script = (string)file_get_contents( dirname( __DIR__ ) . '/design/adminui/javascript/popupmenu/ezpopupmenu.js' );
        foreach ( array( 'data-menu-depth', 'data-menu-submenu', 'data-menu-form', 'data-menu-url', 'data-menu-redirect', 'function _isSafeURL' ) as $needle )
        {
            $this->assertStringContainsString( $needle, $script );
        }
    }

    /** AU-03 */
    public function testDropdownLetsDeclaredMenuOpenersThrough()
    {
        $script = (string)file_get_contents( dirname( __DIR__ ) . '/design/adminui/javascript/ngadminui/app.js' );
        $this->assertSame( 1, preg_match( '/\$\(\x27\.dropdown-menu\x27\)\.on\(\x27click\x27, function \(e\) \{(.*?)\n    \}\);/s', $script, $m ) );
        $guard = strpos( $m[1], "closest('[data-menu-open]')" );
        $stop = strpos( $m[1], 'e.stopPropagation()' );
        $this->assertNotFalse( $guard, 'a click on a data-menu-open entry must reach the document' );
        $this->assertNotFalse( $stop );
        $this->assertLessThan( $stop, $guard );
    }
}
