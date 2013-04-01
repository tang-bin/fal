////////////////////////////////////////////////////////////////////////////////
//
//  FINALBUG ACTIONSCRIPT LIBRARY
//  Copyright 2006-2012 Tang Bin <finalbug1101@gmail.com>
//  All Rights Reserved.
//
//  http://finalbug.org/products/fal
//
////////////////////////////////////////////////////////////////////////////////
package org.finalbug.fal.data
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	public class DataBind
	{
		private static var _instance:DataBind;
		public static function get instance():DataBind
		{
			if(_instance == null)
			{
				_instance = new DataBind(new Private);
			}
			return _instance;
		}
		public function DataBind(p:Private)
		{
		}
		
		////////////////////////////////////////////////////////////////////////
		
		private static var bindID:uint = 0;
		private var bindList:Dictionary = new Dictionary();
		
		public function bindArrayCollection(from:ArrayCollection, to:ArrayCollection, dual:Boolean = false):uint
		{
			var newID:uint = ++ bindID;
			var bo:BindObject = new BindObject(from, to, dual);
			if(!checkExist(bo))
			{
				bindList[newID] = bo;
				bo.addListeners();
			}
			return newID;
		}
		
		private function checkExist(bo:BindObject):Boolean
		{
			for each(var obj:BindObject in bindList)
			{
				if(obj != null && obj.duplicateObject(bo))
				{
					return true;
				}
			}
			return false;
		}
	}
}
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;

class BindObject
{
	public static const TYPE_AC:String = "typeAC";
	
	public var fromData:*;
	public var toData:*;
	public var dual:Boolean = false;
	public var type:String = "";
	
	public function BindObject(from:*, to:*, dual:Boolean)
	{
		this.fromData = from;
		this.toData = to;
		this.dual = dual;
		//
		if(from is ArrayCollection && to is ArrayCollection)
		{
			type = TYPE_AC;
		}
		else
		{
			// error.
		}
	}
	
	public function addListeners():void
	{
		if(type == TYPE_AC)
		{
			var from:ArrayCollection = fromData as ArrayCollection;
			var to:ArrayCollection = toData as ArrayCollection;
			from.addEventListener(CollectionEvent.COLLECTION_CHANGE, fromChangeHandler);
			if(dual)
			{
				to.addEventListener(CollectionEvent.COLLECTION_CHANGE, toChangeHandler);
			}
		}
	}
	
	public function equal(obj:BindObject):Boolean
	{
		if(duplicateObject(obj) &&
			obj.dual == dual &&
			obj.type == type)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public function duplicateObject(obj:BindObject):Boolean
	{
		if(fromData != null && toData != null)
		{
			return (obj.fromData == fromData && obj.toData == toData)
		}
		else
		{
			return false;
		}
	}
	
	private function fromChangeHandler(e:CollectionEvent):void
	{
		this.toData = this.fromData;
	}
	
	private function toChangeHandler(e:CollectionEvent):void
	{
		this.fromData = this.toData;
	}
}
class Private{}