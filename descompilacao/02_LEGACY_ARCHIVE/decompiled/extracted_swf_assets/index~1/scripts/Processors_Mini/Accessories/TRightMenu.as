package Processors_Mini.Accessories
{
   import Foundation_Mini.Utilities.TUtilityString;
   import Logics.Agent.SParametersCore;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   
   public class TRightMenu extends Sprite
   {
      
      public static var STRING_Version:String = "0";
      
      public static var STRING_Service:String = "Contact Customer Service";
      
      public static var FORMAT_Lable:String = "Naruto blast altar(%0)";
      
      public static var STRING_CopyRight:String = "© 2012 All Rights Reserved.";
      
      protected var FContextMenu:ContextMenu;
      
      protected var FItemSupport:ContextMenuItem;
      
      protected var FItemVersion:ContextMenuItem;
      
      protected var FItemFlashVersion:ContextMenuItem;
      
      protected var FItemOffice:ContextMenuItem;
      
      protected var FSupportUrl:String;
      
      protected var FOfficeUrl:String;
      
      public function TRightMenu()
      {
         super();
         this.FContextMenu = new ContextMenu();
         this.FContextMenu.hideBuiltInItems();
         this.FSupportUrl = SParametersCore.SupportUrl;
         this.FOfficeUrl = SParametersCore.OfficeUrl;
         this.AddCustomMenuItems();
      }
      
      protected function AddCustomMenuItems() : void
      {
         var _loc1_:String = null;
         this.FItemSupport = new ContextMenuItem(STRING_Service);
         this.FContextMenu.customItems.push(this.FItemSupport);
         this.FItemSupport.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.MenuSupportUrlHandler);
         _loc1_ = "Version: " + SParametersCore.ClientVersion.toString();
         this.FItemVersion = new ContextMenuItem(_loc1_,true,false);
         this.FContextMenu.customItems.push(this.FItemVersion);
         _loc1_ = "FlashPlayer Version: " + Capabilities.version;
         if(Capabilities.isDebugger)
         {
            _loc1_ += "(Debug)";
         }
         this.FItemFlashVersion = new ContextMenuItem(_loc1_,true,false);
         this.FContextMenu.customItems.push(this.FItemFlashVersion);
         _loc1_ = TUtilityString.Format(FORMAT_Lable,this.FOfficeUrl);
         this.FItemOffice = new ContextMenuItem(_loc1_);
         this.FContextMenu.customItems.push(this.FItemOffice);
         this.FItemOffice.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.MenuOfficeUrlHandler);
      }
      
      protected function MenuOfficeUrlHandler(param1:ContextMenuEvent) : void
      {
         this.ProcessorNavigateToURL(this.FOfficeUrl);
      }
      
      protected function MenuSupportUrlHandler(param1:ContextMenuEvent) : void
      {
         this.ProcessorNavigateToURL(this.FSupportUrl);
      }
      
      protected function ProcessorNavigateToURL(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         _loc2_ = new URLRequest(param1);
         navigateToURL(_loc2_,"_blank");
      }
      
      public function get MyContextMenu() : ContextMenu
      {
         return this.FContextMenu;
      }
      
      public function set Version(param1:String) : void
      {
         this.FItemVersion.caption = "Version: " + param1;
      }
      
      public function Dispose() : void
      {
         this.FItemOffice.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.MenuOfficeUrlHandler);
         this.FItemSupport.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.MenuSupportUrlHandler);
         this.FContextMenu.customItems.length = 0;
         this.FContextMenu = null;
      }
   }
}

