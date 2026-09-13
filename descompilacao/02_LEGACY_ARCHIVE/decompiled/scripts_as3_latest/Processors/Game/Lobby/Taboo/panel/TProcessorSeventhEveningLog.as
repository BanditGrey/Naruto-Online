package Processors.Game.Lobby.Taboo.panel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.TBarSprite;
   import Resources.Constants.CONST_TABOO;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class TProcessorSeventhEveningLog extends TProcessorLobbyWindow
   {
      
      protected static var JianGe:int = 300;
      
      protected var MainPanel:Sprite = null;
      
      protected var FMC_BackBtn:MovieClip = null;
      
      protected var FMC_CloseBtn:SimpleButton = null;
      
      protected var FTF_Tip:TextField = null;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var FTBarSpriteVector:Vector.<TBarSprite>;
      
      protected var FTimeAddItem:Timer;
      
      protected var FIsCanBack:Boolean;
      
      protected var FBackFun:Function;
      
      public function TProcessorSeventhEveningLog(param1:TUIComponent)
      {
         super(param1);
         this.FTBarSpriteVector = new Vector.<TBarSprite>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TABOO.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MC_SeventhEveningLog) as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FMC_BackBtn = this.MainPanel["MC_BackBtn"];
         this.FMC_CloseBtn = this.MainPanel["MC_CloseBtn"];
         this.FTF_Tip = this.MainPanel["TF_Tip"];
         this.FMC_BackBtn.addEventListener(MouseEvent.CLICK,this.MCClick);
         this.FMC_CloseBtn.addEventListener(MouseEvent.CLICK,this.MCClick);
         TGameUtil.setButtonMode(this.FMC_BackBtn,true);
         this.FScrollBar = new TScrollBar(this.MainPanel["MC_List"],125,true,0);
         this.FScrollBar.Clear();
         this.FTF_Tip.visible = false;
         this.FTimeAddItem = new Timer(JianGe);
         this.FTimeAddItem.addEventListener(TimerEvent.TIMER,this.TimeHandle);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function MCClick(param1:MouseEvent) : void
      {
         if(!this.FIsCanBack)
         {
            return;
         }
         if(this.FBackFun != null)
         {
            this.FBackFun();
         }
         this.visible = false;
      }
      
      protected function TimeHandle(param1:TimerEvent) : void
      {
         var _loc2_:TBarSprite = null;
         if(this.FTBarSpriteVector.length > 0)
         {
            _loc2_ = this.FTBarSpriteVector.shift();
            this.FScrollBar.AddItem(_loc2_);
            this.FScrollBar.ScrollToDown();
         }
         else
         {
            this.FTimeAddItem.reset();
            this.FTimeAddItem.stop();
            this.FTF_Tip.visible = false;
            this.FIsCanBack = true;
         }
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function SetValue(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         this.FTBarSpriteVector.length = 0;
         this.FScrollBar.Clear();
         var _loc10_:TBarSprite = null;
         _loc4_ = param1.readShort();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc6_ = param1.readUnsignedInt();
            if(_loc2_ > 0)
            {
               _loc10_ = new TBarSprite();
               _loc10_.DreawLine();
               this.FTBarSpriteVector.push(_loc10_);
            }
            _loc10_ = new TBarSprite();
            _loc10_.SetNameCopy(_loc6_);
            this.FTBarSpriteVector.push(_loc10_);
            _loc5_ = param1.readShort();
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc7_ = uint(param1.readShort());
               _loc8_ = param1.readUnsignedInt();
               _loc9_ = param1.readUnsignedInt();
               _loc10_ = new TBarSprite();
               _loc10_.SetName(_loc6_,_loc7_,_loc8_,_loc9_);
               this.FTBarSpriteVector.push(_loc10_);
               _loc3_++;
            }
            _loc2_++;
         }
         _loc10_ = new TBarSprite();
         _loc10_.DreawLine7();
         this.FTBarSpriteVector.push(_loc10_);
         this.FTimeAddItem.start();
         this.FTF_Tip.visible = true;
         this.FIsCanBack = true;
      }
   }
}

